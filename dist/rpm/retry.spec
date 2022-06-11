#
# spec file for package retry
#
# Copyright SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

%bcond_without tests

Name:           retry
Version:        1
Release:        0
Summary:        A simply retry tool in plain POSIX sh
License:        MIT
Group:          Development/Tools/Other
BuildArch:      noarch
Url:            https://github.com/okurz/retry
Source0:        %{name}-%{version}.tar.xz
%if %{with tests}
BuildRequires:  perl git-core checkbashisms
%endif

%description
A simply retry tool in plain POSIX sh.

%prep
%setup -q

%build

%install
mkdir -p %{buildroot}%{_bindir}
%make_install

%check
%if %{with tests}
make test
%endif

%files
%{_bindir}/retry

%changelog
