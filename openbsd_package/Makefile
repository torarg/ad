COMMENT =	helper to create and manage ansible deployments.
V       = 0.0.1
DISTNAME =	ad-${V}

CATEGORIES =	sysutils

HOMEPAGE =	https://github.com/torarg/ad

MAINTAINER =		Michael Wilson <mw@1wilson.org>

# BSD
PERMIT_PACKAGE =	Yes

SITES =		https://github.com/torarg/ad/releases/download/${V}/
SITES =		https://github.com/torarg/ad/archive/refs/tags/
DISTFILES = ad-{}${V}${EXTRACT_SUFX}

RUN_DEPENDS = sysutils/ansible devel/git devel/git-crypt shells/bash security/gnupg textproc/yq

.include <bsd.port.mk>
