build: fetch
	xcodebuild -project ld64/ld64.xcodeproj -scheme ld -derivedDataPath build -configuration Release build

clean:
	rm -rf dyld llvm.src tapi corecrypto ld64

fetch: dyld llvm.src tapi corecrypto ld64

dyld:
	mkdir -p $@
	curl -# -L https://opensource.apple.com/tarballs/dyld/dyld-832.7.3.tar.gz | tar xz -C $@ --strip-components=1
	patch -p1 -d $@ < patches/dyld.patch

llvm.src:
	mkdir -p $@
	curl -# -L https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.0/llvm-12.0.0.src.tar.xz | tar xJ -C $@ --strip-components=1

tapi:
	mkdir -p $@
	curl -# -L https://opensource.apple.com/tarballs/tapi/tapi-1100.0.11.tar.gz | tar xz -C $@ --strip-components=1
	patch -p1 -d $@ < patches/tapi.patch

corecrypto:
	mkdir -p xnu
	mkdir -p corecrypto/include
	curl -# -L https://opensource.apple.com/tarballs/xnu/xnu-7195.81.3.tar.gz | tar xz -C xnu --strip-components=1 && mv xnu/EXTERNAL_HEADERS/corecrypto corecrypto/include && rm -r xnu

ld64:
	mkdir -p $@
	curl -# -L https://opensource.apple.com/tarballs/ld64/ld64-609.tar.gz | tar xz -C $@ --strip-components=1
	patch -p1 -d $@ < patches/ld64.patch
