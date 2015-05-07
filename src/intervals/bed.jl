# WARNING: This file was generated from bed.rl using ragel. Do not edit!
immutable BED <: FileFormat end

@doc """
Metadata for BED interval records.
""" ->
immutable BEDMetadata
    name::Nullable{ASCIIString}
    score::Nullable{Int}
    thick_first::Nullable{Int}
    thick_last::Nullable{Int};
    item_rgb::Nullable{RGB{Float32}};
    block_count::Nullable{Int}
    block_sizes::Nullable{Vector{Int}}
    block_firsts::Nullable{Vector{Int}}

    function BEDMetadata(name=Nullable{ASCIIString}(),
                         score=Nullable{Int}(),
                         thick_first=Nullable{Int}(),
                         thick_last=Nullable{Int}(),
                         item_rgb=Nullable{Float32}(),
                         block_count=Nullable{Int}(),
                         block_sizes=Nullable{Vector{Int}}(),
                         block_firsts=Nullable{Vector{Int}}())
        return new(name, score, thick_first, thick_last, item_rgb,
                   block_count, block_sizes, block_firsts)
    end
end


function (==)(a::BEDMetadata, b::BEDMetadata)
    for name in fieldnames(BEDMetadata)
        aval = getfield(a, name)
        bval = getfield(b, name)
        if !((isnull(aval) && isnull(bval)) || get(aval) == get(bval))
            return false
        end
    end
    return true
end


@doc """
An `Interval` with associated metadata from a BED file.
""" ->
typealias BEDInterval Interval{BEDMetadata}


module BEDParserImpl

import Bio.Intervals: Strand, STRAND_NA, BEDInterval, BEDMetadata
import Bio.Ragel
using Docile, Switch, Compat, Color
export BEDParser, takevalue!


const bed_start  = convert(Int , 41)
const bed_first_final  = convert(Int , 41)
const bed_error  = convert(Int , 0)
const bed_en_main  = convert(Int , 41)
type BEDParser
    state::Ragel.State

    # intermediate values when parsing
    seqname::ASCIIString
    first::Int64
    last::Int64
    strand::Strand

    red::Float32
    green::Float32
    blue::Float32
    name::Nullable{ASCIIString}
    score::Nullable{Int}
    thick_first::Nullable{Int}
    thick_last::Nullable{Int};
    item_rgb::Nullable{RGB{Float32}};
    block_count::Nullable{Int}
    block_sizes::Nullable{Vector{Int}}
    block_firsts::Nullable{Vector{Int}}

    function BEDParser(input::Union(IO, String, Vector{Uint8}),
                       memory_map::Bool=false)
        cs = bed_start;
	return new(Ragel.State(cs, input, memory_map),
                   "", 0, 0, STRAND_NA, 0.0, 0.0, 0.0,
                   Nullable{ASCIIString}(), Nullable{Int}(), Nullable{Int}(),
                   Nullable{Int}(), Nullable{RGB{Float32}}(), Nullable{Int}(),
                   Nullable{Vector{Int}}(), Nullable{Vector{Int}}())
    end
end


function Ragel.ragelstate(parser::BEDParser)
    return parser.state
end


function accept_state!(input::BEDParser, output::BEDInterval)
    output = input.nextitem
    input.nextitem = BEDInterval()
end


function takevalue!(input::BEDParser)
    value = BEDInterval(input.seqname, input.first, input.last, input.strand,
                        BEDMetadata(input.name, input.score, input.thick_first,
                                    input.thick_last, input.item_rgb,
                                    input.block_count, input.block_sizes,
                                    input.block_firsts))
    input.strand = STRAND_NA
    name = Nullable{ASCIIString}()
    score = Nullable{Int}()
    thick_first = Nullable{Int}()
    thick_last = Nullable{Int};()
    item_rgb = Nullable{RGB{Float32}};()
    block_count = Nullable{Int}()
    block_sizes = Nullable{Vector{Int}}()
    block_firsts = Nullable{Vector{Int}}()

    return value
end


Ragel.@generate_read_fuction("bed", BEDParser, BEDInterval,
    begin
        @inbounds begin
            if p == pe 
	@goto _test_eof

end
@switch cs  begin
    @case 41
@goto st_case_41
@case 0
@goto st_case_0
@case 1
@goto st_case_1
@case 2
@goto st_case_2
@case 3
@goto st_case_3
@case 4
@goto st_case_4
@case 5
@goto st_case_5
@case 6
@goto st_case_6
@case 7
@goto st_case_7
@case 8
@goto st_case_8
@case 9
@goto st_case_9
@case 10
@goto st_case_10
@case 11
@goto st_case_11
@case 12
@goto st_case_12
@case 13
@goto st_case_13
@case 14
@goto st_case_14
@case 15
@goto st_case_15
@case 16
@goto st_case_16
@case 17
@goto st_case_17
@case 18
@goto st_case_18
@case 19
@goto st_case_19
@case 20
@goto st_case_20
@case 21
@goto st_case_21
@case 22
@goto st_case_22
@case 23
@goto st_case_23
@case 24
@goto st_case_24
@case 25
@goto st_case_25
@case 26
@goto st_case_26
@case 27
@goto st_case_27
@case 28
@goto st_case_28
@case 29
@goto st_case_29
@case 30
@goto st_case_30
@case 42
@goto st_case_42
@case 31
@goto st_case_31
@case 32
@goto st_case_32
@case 33
@goto st_case_33
@case 34
@goto st_case_34
@case 35
@goto st_case_35
@case 36
@goto st_case_36
@case 37
@goto st_case_37
@case 38
@goto st_case_38
@case 39
@goto st_case_39
@case 40
@goto st_case_40

end
@goto st_out
@label ctr2
	input.state.linenum += 1 
@goto st41
@label st41
p+= 1;
	if p == pe 
	@goto _test_eof41

end
@label st_case_41
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr83
@case 10
@goto ctr2
@case 11
@goto st2
@case 13
@goto st3
@case 32
@goto ctr84

end
if 33 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto ctr85

end
@goto st0
@label st_case_0
@label st0
cs = 0;
	@goto _out
@label ctr81
	input.seqname      = Ragel.@asciistring_from_mark! 
@goto st1
@label ctr83
	Ragel.@pushmark! 
	input.seqname      = Ragel.@asciistring_from_mark! 
@goto st1
@label st1
p+= 1;
	if p == pe 
	@goto _test_eof1

end
@label st_case_1
@switch ( data[1 + p ])  begin
    @case 9
@goto st2
@case 10
@goto ctr2
@case 11
@goto st2
@case 13
@goto st3
@case 32
@goto st2

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr4

end
@goto st0
@label st2
p+= 1;
	if p == pe 
	@goto _test_eof2

end
@label st_case_2
@switch ( data[1 + p ])  begin
    @case 9
@goto st2
@case 10
@goto ctr2
@case 11
@goto st2
@case 13
@goto st3
@case 32
@goto st2

end
@goto st0
@label st3
p+= 1;
	if p == pe 
	@goto _test_eof3

end
@label st_case_3
if ( data[1 + p ]) == 10 
	@goto ctr2

end
@goto st0
@label ctr4
	Ragel.@pushmark! 
@goto st4
@label st4
p+= 1;
	if p == pe 
	@goto _test_eof4

end
@label st_case_4
if ( data[1 + p ]) == 9 
	@goto ctr5

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st4

end
@goto st0
@label ctr5
	input.first        = Ragel.@int64_from_mark! 
@goto st5
@label st5
p+= 1;
	if p == pe 
	@goto _test_eof5

end
@label st_case_5
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr7

end
@goto st0
@label ctr7
	Ragel.@pushmark! 
@goto st6
@label st6
p+= 1;
	if p == pe 
	@goto _test_eof6

end
@label st_case_6
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr8
@case 10
@goto ctr9
@case 13
@goto ctr10

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st6

end
@goto st0
@label ctr8
	input.last         = Ragel.@int64_from_mark! 
@goto st7
@label st7
p+= 1;
	if p == pe 
	@goto _test_eof7

end
@label st_case_7
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr12
@case 10
@goto ctr13
@case 13
@goto ctr14

end
if 32 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto ctr15

end
@goto st0
@label ctr12
	Ragel.@pushmark! 
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
@goto st8
@label ctr77
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
@goto st8
@label st8
p+= 1;
	if p == pe 
	@goto _test_eof8

end
@label st_case_8
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr16

end
@goto st0
@label ctr16
	Ragel.@pushmark! 
@goto st9
@label st9
p+= 1;
	if p == pe 
	@goto _test_eof9

end
@label st_case_9
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr17
@case 10
@goto ctr18
@case 13
@goto ctr19

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st9

end
@goto st0
@label ctr17
	input.score        = Ragel.@int64_from_mark! 
@goto st10
@label st10
p+= 1;
	if p == pe 
	@goto _test_eof10

end
@label st_case_10
@switch ( data[1 + p ])  begin
    @case 43
@goto ctr21
@case 63
@goto ctr21

end
if 45 <= ( data[1 + p ]) && ( data[1 + p ]) <= 46 
	@goto ctr21

end
@goto st0
@label ctr21
	input.strand       = convert(Strand, Ragel.@char) 
@goto st11
@label st11
p+= 1;
	if p == pe 
	@goto _test_eof11

end
@label st_case_11
@switch ( data[1 + p ])  begin
    @case 9
@goto st12
@case 10
@goto ctr23
@case 13
@goto st33

end
@goto st0
@label st12
p+= 1;
	if p == pe 
	@goto _test_eof12

end
@label st_case_12
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr25

end
@goto st0
@label ctr25
	Ragel.@pushmark! 
@goto st13
@label st13
p+= 1;
	if p == pe 
	@goto _test_eof13

end
@label st_case_13
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr26
@case 10
@goto ctr27
@case 13
@goto ctr28

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st13

end
@goto st0
@label ctr26
	input.thick_first  = Ragel.@int64_from_mark! 
@goto st14
@label st14
p+= 1;
	if p == pe 
	@goto _test_eof14

end
@label st_case_14
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr30

end
@goto st0
@label ctr30
	Ragel.@pushmark! 
@goto st15
@label st15
p+= 1;
	if p == pe 
	@goto _test_eof15

end
@label st_case_15
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr31
@case 10
@goto ctr32
@case 13
@goto ctr33

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st15

end
@goto st0
@label ctr31
	input.thick_last   = Ragel.@int64_from_mark! 
@goto st16
@label st16
p+= 1;
	if p == pe 
	@goto _test_eof16

end
@label st_case_16
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr35

end
@goto st0
@label ctr35
	Ragel.@pushmark! 
@goto st17
@label st17
p+= 1;
	if p == pe 
	@goto _test_eof17

end
@label st_case_17
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr36
@case 10
@goto ctr37
@case 11
@goto ctr38
@case 13
@goto ctr39
@case 32
@goto ctr38
@case 44
@goto ctr40

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st17

end
@goto st0
@label ctr36
	input.red = input.green = input.blue = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
@goto st18
@label st18
p+= 1;
	if p == pe 
	@goto _test_eof18

end
@label st_case_18
@switch ( data[1 + p ])  begin
    @case 9
@goto st19
@case 11
@goto st19
@case 32
@goto st19
@case 44
@goto st20

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr44

end
@goto st0
@label ctr38
	input.red = input.green = input.blue = (Ragel.@int64_from_mark!) / 255.0 
@goto st19
@label st19
p+= 1;
	if p == pe 
	@goto _test_eof19

end
@label st_case_19
@switch ( data[1 + p ])  begin
    @case 9
@goto st19
@case 11
@goto st19
@case 32
@goto st19
@case 44
@goto st20

end
@goto st0
@label ctr40
	input.red = input.green = input.blue = (Ragel.@int64_from_mark!) / 255.0 
@goto st20
@label st20
p+= 1;
	if p == pe 
	@goto _test_eof20

end
@label st_case_20
@switch ( data[1 + p ])  begin
    @case 9
@goto st20
@case 11
@goto st20
@case 32
@goto st20

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr45

end
@goto st0
@label ctr45
	Ragel.@pushmark! 
@goto st21
@label st21
p+= 1;
	if p == pe 
	@goto _test_eof21

end
@label st_case_21
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr46
@case 11
@goto ctr46
@case 32
@goto ctr46
@case 44
@goto ctr47

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st21

end
@goto st0
@label ctr46
	input.green        = (Ragel.@int64_from_mark!) / 255.0 
@goto st22
@label st22
p+= 1;
	if p == pe 
	@goto _test_eof22

end
@label st_case_22
@switch ( data[1 + p ])  begin
    @case 9
@goto st22
@case 11
@goto st22
@case 32
@goto st22
@case 44
@goto st23

end
@goto st0
@label ctr47
	input.green        = (Ragel.@int64_from_mark!) / 255.0 
@goto st23
@label st23
p+= 1;
	if p == pe 
	@goto _test_eof23

end
@label st_case_23
@switch ( data[1 + p ])  begin
    @case 9
@goto st23
@case 11
@goto st23
@case 32
@goto st23

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr51

end
@goto st0
@label ctr51
	Ragel.@pushmark! 
@goto st24
@label st24
p+= 1;
	if p == pe 
	@goto _test_eof24

end
@label st_case_24
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr52
@case 10
@goto ctr53
@case 13
@goto ctr54

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st24

end
@goto st0
@label ctr52
	input.blue         = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
@goto st25
@label st25
p+= 1;
	if p == pe 
	@goto _test_eof25

end
@label st_case_25
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr44

end
@goto st0
@label ctr44
	Ragel.@pushmark! 
@goto st26
@label st26
p+= 1;
	if p == pe 
	@goto _test_eof26

end
@label st_case_26
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr56
@case 10
@goto ctr57
@case 13
@goto ctr58

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st26

end
@goto st0
@label ctr56
	input.block_count  = Ragel.@int64_from_mark! 
@goto st27
@label st27
p+= 1;
	if p == pe 
	@goto _test_eof27

end
@label st_case_27
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr60

end
@goto st0
@label ctr60
	Ragel.@pushmark! 
@goto st28
@label st28
p+= 1;
	if p == pe 
	@goto _test_eof28

end
@label st_case_28
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr61
@case 10
@goto ctr62
@case 13
@goto ctr63
@case 44
@goto ctr64

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st28

end
@goto st0
@label ctr61
	if isnull(input.block_sizes)
            input.block_sizes = Array(Int, 0)
        end
        push!(get(input.block_sizes), (Ragel.@int64_from_mark!))
    
@goto st29
@label st29
p+= 1;
	if p == pe 
	@goto _test_eof29

end
@label st_case_29
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr66

end
@goto st0
@label ctr66
	Ragel.@pushmark! 
@goto st30
@label st30
p+= 1;
	if p == pe 
	@goto _test_eof30

end
@label st_case_30
@switch ( data[1 + p ])  begin
    @case 10
@goto ctr67
@case 13
@goto ctr68
@case 44
@goto ctr69

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto st30

end
@goto st0
@label ctr23
	input.state.linenum += 1 
@goto st42
@label ctr9
	input.last         = Ragel.@int64_from_mark! 
	input.state.linenum += 1 
@goto st42
@label ctr13
	Ragel.@pushmark! 
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
	input.state.linenum += 1 
@goto st42
@label ctr18
	input.score        = Ragel.@int64_from_mark! 
	input.state.linenum += 1 
@goto st42
@label ctr27
	input.thick_first  = Ragel.@int64_from_mark! 
	input.state.linenum += 1 
@goto st42
@label ctr32
	input.thick_last   = Ragel.@int64_from_mark! 
	input.state.linenum += 1 
@goto st42
@label ctr37
	input.red = input.green = input.blue = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
	input.state.linenum += 1 
@goto st42
@label ctr53
	input.blue         = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
	input.state.linenum += 1 
@goto st42
@label ctr57
	input.block_count  = Ragel.@int64_from_mark! 
	input.state.linenum += 1 
@goto st42
@label ctr62
	if isnull(input.block_sizes)
            input.block_sizes = Array(Int, 0)
        end
        push!(get(input.block_sizes), (Ragel.@int64_from_mark!))
    
	input.state.linenum += 1 
@goto st42
@label ctr67
	if isnull(input.block_firsts)
            input.block_firsts = Array(Int, 0)
        end
        push!(get(input.block_firsts), (Ragel.@int64_from_mark!))
    
	input.state.linenum += 1 
@goto st42
@label ctr78
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
	input.state.linenum += 1 
@goto st42
@label st42
p+= 1;
	if p == pe 
	@goto _test_eof42

end
@label st_case_42
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr86
@case 10
@goto ctr23
@case 11
@goto st32
@case 13
@goto st33
@case 32
@goto ctr87

end
if 33 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto ctr88

end
@goto st0
@label ctr72
	input.seqname      = Ragel.@asciistring_from_mark! 
@goto st31
@label ctr86
	yield = true
        # // fbreak causes will cause the pushmark action for the next seqname
        # // to be skipped, so we do it here
        Ragel.@pushmark!
        	p+= 1; cs = 31; @goto _out


    
	Ragel.@pushmark! 
	input.seqname      = Ragel.@asciistring_from_mark! 
@goto st31
@label st31
p+= 1;
	if p == pe 
	@goto _test_eof31

end
@label st_case_31
@switch ( data[1 + p ])  begin
    @case 9
@goto st32
@case 10
@goto ctr23
@case 11
@goto st32
@case 13
@goto st33
@case 32
@goto st32

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr4

end
@goto st0
@label st32
p+= 1;
	if p == pe 
	@goto _test_eof32

end
@label st_case_32
@switch ( data[1 + p ])  begin
    @case 9
@goto st32
@case 10
@goto ctr23
@case 11
@goto st32
@case 13
@goto st33
@case 32
@goto st32

end
@goto st0
@label ctr10
	input.last         = Ragel.@int64_from_mark! 
@goto st33
@label ctr14
	Ragel.@pushmark! 
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
@goto st33
@label ctr19
	input.score        = Ragel.@int64_from_mark! 
@goto st33
@label ctr28
	input.thick_first  = Ragel.@int64_from_mark! 
@goto st33
@label ctr33
	input.thick_last   = Ragel.@int64_from_mark! 
@goto st33
@label ctr39
	input.red = input.green = input.blue = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
@goto st33
@label ctr54
	input.blue         = (Ragel.@int64_from_mark!) / 255.0 
	input.item_rgb     = RGB{Float32}(input.red, input.green, input.blue ) 
@goto st33
@label ctr58
	input.block_count  = Ragel.@int64_from_mark! 
@goto st33
@label ctr63
	if isnull(input.block_sizes)
            input.block_sizes = Array(Int, 0)
        end
        push!(get(input.block_sizes), (Ragel.@int64_from_mark!))
    
@goto st33
@label ctr68
	if isnull(input.block_firsts)
            input.block_firsts = Array(Int, 0)
        end
        push!(get(input.block_firsts), (Ragel.@int64_from_mark!))
    
@goto st33
@label ctr79
	input.name         = Nullable{ASCIIString}(Ragel.@asciistring_from_mark!) 
@goto st33
@label st33
p+= 1;
	if p == pe 
	@goto _test_eof33

end
@label st_case_33
if ( data[1 + p ]) == 10 
	@goto ctr23

end
@goto st0
@label ctr87
	yield = true
        # // fbreak causes will cause the pushmark action for the next seqname
        # // to be skipped, so we do it here
        Ragel.@pushmark!
        	p+= 1; cs = 34; @goto _out


    
	Ragel.@pushmark! 
@goto st34
@label st34
p+= 1;
	if p == pe 
	@goto _test_eof34

end
@label st_case_34
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr72
@case 10
@goto ctr23
@case 11
@goto st32
@case 13
@goto st33
@case 32
@goto st34

end
if 33 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto st35

end
@goto st0
@label ctr85
	Ragel.@pushmark! 
@goto st35
@label ctr88
	yield = true
        # // fbreak causes will cause the pushmark action for the next seqname
        # // to be skipped, so we do it here
        Ragel.@pushmark!
        	p+= 1; cs = 35; @goto _out


    
	Ragel.@pushmark! 
@goto st35
@label st35
p+= 1;
	if p == pe 
	@goto _test_eof35

end
@label st_case_35
if ( data[1 + p ]) == 9 
	@goto ctr75

end
if 32 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto st35

end
@goto st0
@label ctr75
	input.seqname      = Ragel.@asciistring_from_mark! 
@goto st36
@label st36
p+= 1;
	if p == pe 
	@goto _test_eof36

end
@label st_case_36
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr4

end
@goto st0
@label ctr69
	if isnull(input.block_firsts)
            input.block_firsts = Array(Int, 0)
        end
        push!(get(input.block_firsts), (Ragel.@int64_from_mark!))
    
@goto st37
@label st37
p+= 1;
	if p == pe 
	@goto _test_eof37

end
@label st_case_37
@switch ( data[1 + p ])  begin
    @case 10
@goto ctr23
@case 13
@goto st33

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr66

end
@goto st0
@label ctr64
	if isnull(input.block_sizes)
            input.block_sizes = Array(Int, 0)
        end
        push!(get(input.block_sizes), (Ragel.@int64_from_mark!))
    
@goto st38
@label st38
p+= 1;
	if p == pe 
	@goto _test_eof38

end
@label st_case_38
@switch ( data[1 + p ])  begin
    @case 9
@goto st29
@case 10
@goto ctr23
@case 13
@goto st33

end
if 48 <= ( data[1 + p ]) && ( data[1 + p ]) <= 57 
	@goto ctr60

end
@goto st0
@label ctr15
	Ragel.@pushmark! 
@goto st39
@label st39
p+= 1;
	if p == pe 
	@goto _test_eof39

end
@label st_case_39
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr77
@case 10
@goto ctr78
@case 13
@goto ctr79

end
if 32 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto st39

end
@goto st0
@label ctr84
	Ragel.@pushmark! 
@goto st40
@label st40
p+= 1;
	if p == pe 
	@goto _test_eof40

end
@label st_case_40
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr81
@case 10
@goto ctr2
@case 11
@goto st2
@case 13
@goto st3
@case 32
@goto st40

end
if 33 <= ( data[1 + p ]) && ( data[1 + p ]) <= 126 
	@goto st35

end
@goto st0
@label st_out
@label _test_eof41
cs = 41; @goto _test_eof
@label _test_eof1
cs = 1; @goto _test_eof
@label _test_eof2
cs = 2; @goto _test_eof
@label _test_eof3
cs = 3; @goto _test_eof
@label _test_eof4
cs = 4; @goto _test_eof
@label _test_eof5
cs = 5; @goto _test_eof
@label _test_eof6
cs = 6; @goto _test_eof
@label _test_eof7
cs = 7; @goto _test_eof
@label _test_eof8
cs = 8; @goto _test_eof
@label _test_eof9
cs = 9; @goto _test_eof
@label _test_eof10
cs = 10; @goto _test_eof
@label _test_eof11
cs = 11; @goto _test_eof
@label _test_eof12
cs = 12; @goto _test_eof
@label _test_eof13
cs = 13; @goto _test_eof
@label _test_eof14
cs = 14; @goto _test_eof
@label _test_eof15
cs = 15; @goto _test_eof
@label _test_eof16
cs = 16; @goto _test_eof
@label _test_eof17
cs = 17; @goto _test_eof
@label _test_eof18
cs = 18; @goto _test_eof
@label _test_eof19
cs = 19; @goto _test_eof
@label _test_eof20
cs = 20; @goto _test_eof
@label _test_eof21
cs = 21; @goto _test_eof
@label _test_eof22
cs = 22; @goto _test_eof
@label _test_eof23
cs = 23; @goto _test_eof
@label _test_eof24
cs = 24; @goto _test_eof
@label _test_eof25
cs = 25; @goto _test_eof
@label _test_eof26
cs = 26; @goto _test_eof
@label _test_eof27
cs = 27; @goto _test_eof
@label _test_eof28
cs = 28; @goto _test_eof
@label _test_eof29
cs = 29; @goto _test_eof
@label _test_eof30
cs = 30; @goto _test_eof
@label _test_eof42
cs = 42; @goto _test_eof
@label _test_eof31
cs = 31; @goto _test_eof
@label _test_eof32
cs = 32; @goto _test_eof
@label _test_eof33
cs = 33; @goto _test_eof
@label _test_eof34
cs = 34; @goto _test_eof
@label _test_eof35
cs = 35; @goto _test_eof
@label _test_eof36
cs = 36; @goto _test_eof
@label _test_eof37
cs = 37; @goto _test_eof
@label _test_eof38
cs = 38; @goto _test_eof
@label _test_eof39
cs = 39; @goto _test_eof
@label _test_eof40
cs = 40; @goto _test_eof
@label _test_eof
if p == eof 
	@switch cs  begin
    @case 42
	yield = true
        # // fbreak causes will cause the pushmark action for the next seqname
        # // to be skipped, so we do it here
        Ragel.@pushmark!
        	p+= 1; cs = 0; @goto _out


    

	break;
	
end

end
@label _out
end
    end,
    begin
        # TODO: If I'm going to do actual destructive parsing, I
        # need to be able to do some setup here.
        accept_state!(input, output)
    end)



end # module BEDParserImpl


# This inexplicably doesn't work, which is why I qualify BEDParser below.
#using BEDParserImpl

@doc """
An iterator over entries in a BED file or stream.
""" ->
type BEDIterator <: IntervalStream{BEDMetadata}
    parser::BEDParserImpl.BEDParser
    nextitem::Nullable{BEDInterval}
end


@doc """
Parse a BED file.

# Arguments
  * `filename::String`: Path of the BED file.
  * `memory_map::Bool`: If true, attempt to memory map the file on supported
    platforms. (Default: `false`)

# Returns
An iterator over `BEDInterval`s contained in the file.
""" ->
function read(filename::String, ::Type{BED}; memory_map::Bool=false)
    it = BEDIterator(BEDParserImpl.BEDParser(filename, memory_map),
                       Nullable{BEDInterval}())
    return it
end


@doc """
Parse a BED file.

# Arguments
  * `input::IO`: Input stream containing BED data.

# Returns
An iterator over `BEDInterval`s contained in the file.
""" ->
function read(input::IO, ::Type{BED})
    return BEDIterator(BEDParserImpl.BEDParser(input), Nullable{BEDInterval}())
end


function start(it::BEDIterator)
    advance!(it)
    return nothing
end


function advance!(it::BEDIterator)
    isdone = !BEDParserImpl.advance!(it.parser)
    if isdone
        it.nextitem = Nullable{BEDInterval}()
    else
        it.nextitem = BEDParserImpl.takevalue!(it.parser)
    end
end


function next(it::BEDIterator, state::Nothing)
    item = get(it.nextitem)
    advance!(it)
    return item, nothing
end


function done(it::BEDIterator, state::Nothing)
    return isnull(it.nextitem)
end

