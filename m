Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39B2F527A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfKHRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 12:22:33 -0500
Received: from tragedy.dreamhost.com ([66.33.205.236]:50352 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:22:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by tragedy.dreamhost.com (Postfix) with ESMTPS id 0F93115F884;
        Fri,  8 Nov 2019 09:22:29 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:22:28 +0000 (UTC)
From:   Sage Weil <sage@newdream.net>
X-X-Sender: sage@piezo.novalocal
To:     Luis Henriques <lhenriques@suse.com>
cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] ceph: safely use 'copy-from' Op on Octopus
 OSDs
In-Reply-To: <20191108171616.GA2569@hermes.olymp>
Message-ID: <alpine.DEB.2.21.1911081721120.28682@piezo.novalocal>
References: <20191108141555.31176-1-lhenriques@suse.com> <CAOi1vP-sVQKvpiPLoZ=9s7Hy=c2eQRocxSs1nPrXAUCbbZUZ-g@mail.gmail.com> <20191108164758.GA1760@hermes.olymp> <alpine.DEB.2.21.1911081656320.10553@piezo.novalocal> <20191108171616.GA2569@hermes.olymp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-VR-STATUS: OK
X-VR-SCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvufgjkfhffgggtgesthdtredttdervdenucfhrhhomhepufgrghgvucghvghilhcuoehsrghgvgesnhgvfigurhgvrghmrdhnvghtqeenucfkphepuddvjedrtddrtddrudenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdpihhnvghtpeduvdejrddtrddtrddupdhrvghtuhhrnhdqphgrthhhpefurghgvgcuhggvihhluceoshgrghgvsehnvgifughrvggrmhdrnhgvtheqpdhmrghilhhfrhhomhepshgrghgvsehnvgifughrvggrmhdrnhgvthdpnhhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Luis Henriques wrote:
> On Fri, Nov 08, 2019 at 04:57:27PM +0000, Sage Weil wrote:
> > On Fri, 8 Nov 2019, Luis Henriques wrote:
> > > On Fri, Nov 08, 2019 at 04:15:35PM +0100, Ilya Dryomov wrote:
> > > > If the OSD checked for unknown flags, like newer syscalls do, it would
> > > > be super easy, but it looks like it doesn't.
> > > > 
> > > > An obvious solution is to look at require_osd_release in osdmap, but we
> > > > don't decode that in the kernel because it lives the OSD portion of the
> > > > osdmap.  We could add that and consider the fact that the client now
> > > > needs to decode more than just the client portion a design mistake.
> > > > I'm not sure what can of worms does that open and if copy-from alone is
> > > > worth it though.  Perhaps that field could be moved to (or a copy of it
> > > > be replicated in) the client portion of the osdmap starting with
> > > > octopus?  We seem to be running into it on the client side more and
> > > > more...
> > > 
> > > I can't say I'm thrilled with the idea of going back to hack into the
> > > OSDs code again, I was hoping to be able to handle this with the
> > > information we already have on the connection peer_features field.  It
> > > took me *months* to have the OSD fix merged in so I'm not really
> > > convinced a change to the osdmap would make it into Octopus :-)
> > > 
> > > (But I'll have a look at this and see if I can understand what moving or
> > > replicating the field in the osdmap would really entail.)
> > 
> > Adding a copy of require_osd_release in the client portion of the map is 
> > an easy thing to do (and probably where it should have gone in the first 
> > place!).  Let's do that!
> 
> Yeah, after sending my reply to Ilya I took a quick look and it _seems_
> to be as easy as adding a new encode(require_osd_release...) in the
> OSDMap.  And handle the versions, of course.  Let me spend some time
> playing with that and I'll try to come up with something during the next
> few days.

- You'll need to add it for both OSDMap::Incremental and OSDMap
- You'll need to make the encoding condition by updating the block like 
the one below from OSDMap::encode()

    uint8_t v = 9;
    if (!HAVE_FEATURE(features, SERVER_LUMINOUS)) {
      v = 3;
    } else if (!HAVE_FEATURE(features, SERVER_MIMIC)) {
      v = 6;
    } else if (!HAVE_FEATURE(features, SERVER_NAUTILUS)) {
      v = 7;
    }

to include a SERVER_OCTOPUS case too.  Same goes for Incremental::encode()

sage
