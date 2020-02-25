Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCD16BBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 09:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgBYIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 03:24:53 -0500
Received: from mx.blih.net ([212.83.155.74]:11540 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgBYIYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:24:53 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 03:24:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bidouilliste.com;
        s=mx; t=1582618691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0tcNFyVSsvx4uBxNJ3TEZd+6Xexrm+/hZD6rEjDx54=;
        b=O2bTX0JNfY45haLEpKC8/F3DIkMGLDTYBe/RcW0POYHl+h+maQ8bCqBeDPIrFCD1YUQYeQ
        DCX/9dT0oiOxiWL6fmcofK8pJ4R+hzW/RvA59osWcks6awF07oxBWm2cWEUitxK3tH5rdp
        dfmTukNqQCSoyrGJCHLIr9Lr4l09ON0=
Received: from tails.home (lfbn-idf2-1-900-181.w86-238.abo.wanadoo.fr [86.238.131.181])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id d2c06a04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Feb 2020 08:18:11 +0000 (UTC)
Date:   Tue, 25 Feb 2020 09:18:10 +0100
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        efremov@linux.com, kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, sam@ravnborg.org, tzimmermann@suse.de,
        Emmanuel Vadot <manu@FreeBSD.Org>
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and
 MIT
Message-Id: <20200225091810.1de39ea4e0d578d363420412@bidouilliste.com>
In-Reply-To: <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
References: <20200215180911.18299-1-manu@FreeBSD.org>
        <20200215180911.18299-2-manu@FreeBSD.org>
        <877e0n66qi.fsf@intel.com>
        <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 11:40:38 +0000
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> Quoting Jani Nikula (2020-02-15 18:33:09)
> > On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
> > > From: Emmanuel Vadot <manu@FreeBSD.Org>
> > >
> > > Contributors for this file are :
> > > Chris Wilson <chris@chris-wilson.co.uk>
> > > Denis Efremov <efremov@linux.com>
> > > Jani Nikula <jani.nikula@intel.com>
> > > Maxime Ripard <mripard@kernel.org>
> > > Noralf Tr=F8nnes <noralf@tronnes.org>
> > > Sam Ravnborg <sam@ravnborg.org>
> > > Thomas Zimmermann <tzimmermann@suse.de>
> > >
> > > Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> >=20
> > I've only converted some logging.
> >=20
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
>=20
> Bonus ack from another Intel employee to cover all Intel copyright in
> this file,
> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> -Chris

 Thanks Chris,

 Daniel, if I'm counting right this was the last ack needed.

--=20
Emmanuel Vadot <manu@bidouilliste.com>
