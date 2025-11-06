const std = @import("std");

const allocTZ = std.heap.page_allocator;

const Timezone = struct {
    group: []const u8,
    subgroup : [] const u8,
    city: []const u8,
    key: []const u8,
    name: []const u8
};


// retrieve timstamp nanoseconds tested Linux
fn TSnano() i128 {
        var threaded: std.Io.Threaded = .init_single_threaded;
        const io = threaded.io();
        const ts = std.Io.Clock.real.now(io) catch |err| switch (err) {
        error.UnsupportedClock, error.Unexpected => return 0, 
    };
    return @as(i128, ts.nanoseconds);
}

fn milliTimestamp() i64 {
    return @as(i64, @intCast(@divFloor(TSnano(), std.time.ns_per_ms)));
}


pub fn main() !void {
    const timesStamp_ms :i64 = @bitCast(milliTimestamp());

    const user = std.posix.getenv("USER") orelse "INITTIMEZONE";

    const fileTZ = std.fmt.allocPrint(allocTZ,"/tmp/{s}{d}.txt" ,.{user,timesStamp_ms})  catch unreachable;

    const batch = std.fmt.allocPrint(allocTZ,"/tmp/{s}{d}.sh" ,.{user,timesStamp_ms})  catch unreachable;

    const file = std.fs.cwd().createFile(batch, .{.read = true, .truncate = true,.exclusive = false, })
            catch |err| {
                    const s = @src();
                    @panic( std.fmt.allocPrint(allocTZ,
                    "\n\n\r file:{s} line:{d} column:{d} func:{s} creatFile({s})  err:{}\n\r"
                    ,.{s.file, s.line, s.column,s.fn_name,batch, err, })
                    	catch unreachable);
            };



    // Construire le script Bash ligne par ligne
    var lines = std.ArrayList([]const u8).initCapacity(allocTZ,0) catch unreachable;
    defer lines.deinit(allocTZ);

    try lines.append(allocTZ,"#!/bin/bash");
    try lines.append(allocTZ,"# Show date and time in other time zones");
    try lines.append(allocTZ,"zoneinfo=/usr/share/zoneinfo/");
    try lines.append(allocTZ,"if command -v timedatectl >/dev/null; then");
    try lines.append(allocTZ,"    tzlist=$(timedatectl list-timezones)");
    try lines.append(allocTZ,"fi \n");
    try lines.append(allocTZ,"line=\"\" \n");
    try lines.append(allocTZ,"grep -i \"$search\" <<< \"$tzlist\" | while read z");
    try lines.append(allocTZ,"do \n");
    try lines.append(allocTZ,"    printf -v line \"%-32s%s\" \"$z\" \"|\"");
    try lines.append(allocTZ,std.fmt.allocPrint(allocTZ, "    echo \"$line\" >> {s}", .{fileTZ}) catch unreachable);
    try lines.append(allocTZ,"done");
    try lines.append(allocTZ,std.fmt.allocPrint(allocTZ, "echo \"END\" >> {s}", .{fileTZ}) catch unreachable );
    try lines.append(allocTZ,"exit 0");

    // ecriture du code source batch
    for (lines.items) |line| {
       _= try file.write(line);
       _= try file.write("\n");
    }
    file.close();

    try permission(batch);


    try execute(batch,);


    try readFileTZ(fileTZ) ;

}


// permettre d'executeer le batch pour obtenir la liste timezone
// on ignore le terminal
fn permission( SRC_batch :[]const u8) ! void {
    // the command to run
    const argv = [_][]const u8{ "/bin/chmod","+x",SRC_batch };

    var proc = std.process.Child.init(&argv, allocTZ);

    proc.stdin_behavior = .Ignore;
    proc.stdout_behavior = .Ignore;
    proc.stderr_behavior = .Ignore;

    try proc.spawn();
    _= try proc.wait();
}


// execute le programme batch
fn execute( SRC_batch :[]const u8) ! void {
    // the command to run
    const argv = [_][]const u8{ "/bin/sh","-c",SRC_batch };
    
    var proc = std.process.Child.init(&argv, allocTZ);
    
    proc.stdin_behavior = .Ignore;
    proc.stdout_behavior = .Ignore;
    proc.stderr_behavior = .Ignore;

    try proc.spawn();
    _= try proc.wait();

   const cDIR = std.fs.cwd().openDir("/tmp", .{}) catch unreachable ;
   try cDIR.deleteFile(SRC_batch);
}


// on lite le fichier et l'analyse pour le mettre en sql
fn readFileTZ( file_TZ :[]const u8) ! void {
    const TZ_file = std.fs.cwd().openFile(file_TZ, .{}) catch |err| {
            const s = @src();
            @panic( std.fmt.allocPrint(allocTZ,
            "\n\n\r file:{s} line:{d} column:{d} func:{s} openFile({s})  err:{} \n\r"
            ,.{s.file, s.line, s.column,s.fn_name,file_TZ, err, })
            	catch unreachable);
    };

    const file_size = try TZ_file.getEndPos();
	var buffer : []u8= allocTZ.alloc(u8, file_size) catch unreachable ;


	_= try TZ_file.read(buffer[0..buffer.len]);
    TZ_file.close();

    
	// delete du fichier output de timedatectl
   var cDIR = std.fs.cwd().openDir("/tmp", .{})  catch unreachable ;
   try cDIR.deleteFile(file_TZ); 

    // traitement de la commande timedatectl

	// Parser la sortie
    var array_tmzones = std.ArrayList(Timezone).initCapacity(allocTZ,0) catch unreachable;
    defer array_tmzones.deinit(allocTZ);

    var group : [] const u8 = undefined;
    var group2 : [] const u8 = undefined;
    var subgroup : [] const u8 = undefined;
    var city : [] const u8 = undefined;
    var key  : [] const u8 = undefined;
    var name : [] const u8 = undefined;


    var lines = std.mem.splitAny(u8, buffer, "\n");
    while (lines.next()) |line | {
        if (std.mem.eql(u8,line,"END")) break;


        // séparer region et le temps de décallage
        var parts = std.mem.splitScalar(u8, line, '|');
        key = parts.first();
        parts.reset();
 
        // definir le groupe ouvre des possibilité de choix etc.
        var region_city_parts = std.mem.splitScalar(u8, key , '/');
        var number_slice : usize = 0;
        // find the number of groups
        while(region_city_parts.next())|_|{number_slice += 1;}
        region_city_parts.reset();

        // Preparing to build the timezone.zig source
        if ( number_slice == 1 ) {group = "base"; subgroup = "" ; city =key; name = key;}
            else group = region_city_parts.first();
            
        if ( number_slice > 2 ) subgroup = region_city_parts.next().? else subgroup = "";
        if ( number_slice >= 2 ) { city= region_city_parts.next().?; name = city; }

        if ( std.mem.eql(u8, group, "base") or std.mem.eql(u8, group, "Etc")){
            city = replaceChar(city,"-","m");
            city = replaceChar(city,"+","p");
        }
        else{
            city = replaceChar(city,"-","_");
        }

    
        const tmzone = Timezone{
            .group = std.mem.trim(u8,group," "),
            .subgroup = std.mem.trim(u8,subgroup," "),
            .city = std.mem.trim(u8,city," "),
            .key  = std.mem.trim(u8,key," "),
            .name  = std.mem.trim(u8,name," "),
        };
        // test...
        // std.debug.print(" Groupe: {s:<10} subGroup: {s:<15}  city: {s:<15} key:{s:<32}\n",
        //     .{tmzone.group,tmzone.subgroup,tmzone.city,tmzone.key});

        try array_tmzones.append(allocTZ,tmzone);

        
    }

    var src_lines = std.ArrayList([]const u8).initCapacity(allocTZ,0) catch unreachable;
    defer src_lines.deinit(allocTZ);
    try src_lines.append(allocTZ,"const std = @import(\"std\"); \n\n");

    try src_lines.append(allocTZ,"pub const Timezone = struct {");
    try src_lines.append(allocTZ,"\tid: []const u8");
    try src_lines.append(allocTZ,"};");
    try src_lines.append(allocTZ,"\n\n");
    
    try src_lines.append(allocTZ,"// Auto register timezones");
    try src_lines.append(allocTZ,"fn create(key: []const u8) Timezone {");
    try src_lines.append(allocTZ,"\tconst self = Timezone{ .id = key };");
    try src_lines.append(allocTZ,"\treturn self;");
    try src_lines.append(allocTZ,"}");
    try src_lines.append(allocTZ,"\n");


     try src_lines.append(allocTZ,"// Timezones");
    var index:usize = 1;
    var index_S:usize = 0;  // sous groupe
 // groupe "base"
    group = array_tmzones.items[0].group;
    group2 = "";
    subgroup ="";
    for (array_tmzones.items) | tzone | {

 

        //------------------------------------------------------------------------------------
        // enregistrement sour timezone.zig
        if( !std.mem.eql(u8,subgroup,tzone.subgroup) and index_S == 2 )
              { try src_lines.append(allocTZ,"\t\t};"); subgroup = ""; index_S = 0;} 

      
        if( !std.mem.eql(u8,group,tzone.group) and index == 2 )
              { try src_lines.append(allocTZ,"};"); group = tzone.group; index = 1;} 

        if( !std.mem.eql(u8,group,tzone.group) and index == 3 )
              { group = tzone.group; index = 1;} 

        if ( std.mem.eql(u8, tzone.group, "base")){
            const lkey = std.fmt.allocPrint(allocTZ,
                "pub const {s} = create(\"{s}\");",.{tzone.city,tzone.key}) catch unreachable;
            try src_lines.append(allocTZ,lkey);
            group = tzone.group;
            index = 3;            
            continue;
        }

        if ( index == 1 ){
            const lgroup = std.fmt.allocPrint(allocTZ, "pub const {s} = struct {s}",
                .{tzone.group,"{"}) catch unreachable;
            try src_lines.append(allocTZ,lgroup);
            index = 2;
        }

        if ( !std.mem.eql(u8,tzone.subgroup , "") and index_S == 0) {
            const sgroup = std.fmt.allocPrint(allocTZ, "\t\tpub const {s} = struct {s}",
                .{tzone.subgroup,"{"}) catch unreachable;
            try src_lines.append(allocTZ,sgroup);
            subgroup = tzone.subgroup;
            index_S = 2;
        }
        
        if (index == 2 and index_S == 0){
            const lcity = std.fmt.allocPrint(allocTZ,
                "\tpub const {s} = create(\"{s}\");",.{tzone.city,tzone.key}) catch unreachable;
            try src_lines.append(allocTZ,lcity);
        }
            if (index == 2 and index_S > 0){
            const lcity = std.fmt.allocPrint(allocTZ,
                "\t\t\tpub const {s} = create(\"{s}\");",.{tzone.city,tzone.key}) catch unreachable;
            try src_lines.append(allocTZ,lcity);
        }
    } 


    cDIR = std.fs.cwd().openDir("./libdate/datetime/",.{})
    catch |err| {@panic(try std.fmt.allocPrint(allocTZ,"err Open DIR.{any}\n", .{err}));};

    const fsrc = cDIR.createFile("timezones.zig", .{.read = true, .truncate = true,.exclusive = false, })
            catch |err| {
                    const s = @src();
                    @panic( std.fmt.allocPrint(allocTZ,
                    "\n\n\r file:{s} line:{d} column:{d} func:{s} creatFile({s})  err:{}\n\r"
                    ,.{s.file, s.line, s.column,s.fn_name,"timezone.zig", err, })
                    	catch unreachable);
            };
    defer fsrc.close();

    // ecriture du code source "timezone.zig"
    for (src_lines.items) |line| {
       _= try fsrc.write(line);
       _= try fsrc.write("\n");
    }


}


/// Iterator support iteration string
pub const iteratStr = struct {
	var strbuf:[] const u8 = undefined;

	/// Errors that may occur when using String
	pub const ErrNbrch = error{
		InvalideAllocBuffer,
	};
	


	pub const StringIterator = struct {
		buf: []u8 ,
		index: usize ,


		fn allocBuffer ( size :usize) ErrNbrch![]u8 {
			const buf = allocTZ.alloc(u8, size) catch {
				return ErrNbrch.InvalideAllocBuffer;
			};
			return buf;
		}

		/// Deallocates the internal buffer
		pub fn deinit(self: *StringIterator) void {
			if (self.buf.len > 0)	allocTZ.free(self.buf);
			strbuf = undefined;
		}

		pub fn next(it: *StringIterator) ?[]const u8 {
			const optional_buf: ?[]u8	= allocBuffer(strbuf.len) catch return null;
			
			it.buf= optional_buf orelse "";
			var idx : usize = 0;

			while (true) {
				if (idx >= strbuf.len) break;
				it.buf[idx] = strbuf[idx];
				idx += 1;
			}

			if (it.index == it.buf.len) return null;
			idx = it.index;
			it.index += getUTF8Size(it.buf[idx]);
			return it.buf[idx..it.index];
		}

	};

	/// iterator String
	pub fn iterator(str:[] const u8) StringIterator {
		// strbuf = std.fmt.allocPrint(allocUtl,"{s}", str) catch |err| {@panic(@errorName(err));};
        strbuf = str;
		return StringIterator{
			.buf = undefined,
			.index = 0,
		};
	}

	/// Returns the UTF-8 character's size
	fn getUTF8Size(char: u8) u3 {
		return std.unicode.utf8ByteSequenceLength(char) 
			catch |err| { @panic(@errorName(err));};
	}
};


fn removeChar(buf :[]const u8 , char : []const u8) []const u8 {
    var str : [] const u8 = "";
    var iter = iteratStr.iterator(buf);
    while (iter.next()) |ch| {
        if (!std.mem.eql(u8, ch , char)) 
                str = std.fmt.allocPrint(allocTZ, "{s}{s}",.{str,ch}) catch unreachable ;
    }
    defer iter.deinit();
    return str;   
}

fn replaceChar(buf :[]const u8 , char : []const u8, remplacement : []const u8) []const u8 {
    var str : [] const u8 = "";
    var iter = iteratStr.iterator(buf);
    while (iter.next()) |ch| {
        if ( std.mem.eql(u8, ch , char))
            str = std.fmt.allocPrint(allocTZ, "{s}{s}",.{str,remplacement}) catch unreachable
        else str = std.fmt.allocPrint(allocTZ, "{s}{s}",.{str,ch}) catch unreachable ;
    }
    defer iter.deinit();
    return str;
 }
