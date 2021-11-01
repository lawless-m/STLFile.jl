module STLFile

using TriMesh
using Printf

export STL_ASCII, STL_BIN

function STL_ASCII(n::Net)
	STL_ASCII(n, STDOUT)
end

function STL_ASCII(n::Net, fn::String)
	fid = open(fn, "w+")
	STL_ASCII(n, fid)
	close(fid)
end

function STL_ASCII(n::Net, io::IO)
	println(io, "solid Mesh.jl")
	for f in n.Faces
		abf = n.Vertices[f.AB.From]
		abt = n.Vertices[f.AB.To]
		bct = n.Vertices[f.BC.To]
		@printf(io, "facet normal 0 0 0\n\touter loop\n\t\tvertex %e %e %e\n\t\tvertex %e %e %e\n\t\tvertex %e %e %e\nendloop\n", abf.x, abf.y, abf.z, abt.x, abt.y, abt.z, bct.x, bct.y, bct.z)
	end
	println(io, "endsolid Mesh.jl")
end

function STL_BIN(n::Net)
	STL(n, STDOUT)
end

function STL_BIN(n::Net, fn::String)
	fid = open(fn, "w+")
	STL(n, fid)
	close(fid)
end

function STL_BIN(n::Net, io)
	for k in 1:10
		write(io, Int64(0))
	end
	write(io, Int32(length(n.Faces)))
	for f in n.Faces
		write(io, Float32(0), Float32(0), Float32(0),  f.AB.From.x, f.AB.From.y, f.AB.From.z, f.AB.To.x, f.AB.To.y, f.AB.To.z, f.BC.To.x, f.BC.To.y, f.BC.To.z)
	end
	write(io, Int16(0))
end

### STAHP

end
