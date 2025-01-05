DISTNAME		=	ad-${V}
V				=	0.0.5
COMMENT			=	helper to create and manage ansible deployments.
CATEGORIES		=	sysutils

MAINTAINER		=	Michael Wilson <mw@1wilson.org>
HOMEPAGE 		=	https://github.com/torarg/ad

# BSD
PERMIT_PACKAGE	=	Yes

SITES			=	https://github.com/torarg/ad/archive/refs/tags/
DISTFILES		=	ad-{}${V}${EXTRACT_SUFX}

RUN_DEPENDS		=	sysutils/ansible \
                    devel/git \
                    devel/git-crypt \
                    security/gnupg \
                    textproc/yq

.include <bsd.port.mk>
