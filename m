Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14342E989D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJ3JBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:01:15 -0400
Received: from latin.grep.be ([46.4.76.168]:50005 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:01:13 -0400
Received: from [105.12.0.33] (helo=gangtai.home.grep.be)
        by latin.grep.be with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <w@uter.be>)
        id 1iPjZ3-0008Al-Rc; Wed, 30 Oct 2019 09:42:49 +0100
Received: from wouter by gangtai.home.grep.be with local (Exim 4.92.3)
        (envelope-from <w@uter.be>)
        id 1iPjY2-0006rQ-9L; Wed, 30 Oct 2019 10:41:46 +0200
Date:   Wed, 30 Oct 2019 10:41:46 +0200
From:   Wouter Verhelst <w@uter.be>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in nbd_ioctl
Message-ID: <20191030084146.GE25097@grep.be>
References: <000000000000b1b1ee0593cce78f@google.com>
 <5D93C2DD.10103@redhat.com>
 <20191017140330.GB25667@redhat.com>
 <20191030083957.GD25097@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030083957.GD25097@grep.be>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:39:57AM +0200, Wouter Verhelst wrote:
> On Thu, Oct 17, 2019 at 03:03:30PM +0100, Richard W.M. Jones wrote:
> > On Tue, Oct 01, 2019 at 04:19:25PM -0500, Mike Christie wrote:
> > > Hey Josef and nbd list,
> > > 
> > > I had a question about if there are any socket family restrictions for nbd?
> > 
> > In normal circumstances, in userspace, the NBD protocol would only be
> > used over AF_UNIX or AF_INET/AF_INET6.
> 
> Note that someone once also did work to make it work over SCTP. I
> incorporated the patch into nbd-client and nbd-server, but never
> actually tested it myself. I have no way of knowing if it even still
> works anymore...

Actually, I meant SDP (as you pointed out downthread). Sorry for the
confusion ;-)

(I should probably kick that out though, indeed)

-- 
To the thief who stole my anti-depressants: I hope you're happy

  -- seen somewhere on the Internet on a photo of a billboard
