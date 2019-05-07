Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F715D14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEGGJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 02:09:43 -0400
Received: from mx1.chost.de ([5.175.28.52]:33198 "EHLO mx1.chost.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfEGGJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:09:42 -0400
Received: from vm002.chost.de ([::ffff:192.168.122.102])
  by mx1.chost.de with SMTP; Tue, 07 May 2019 08:10:28 +0200
  id 000000000133ACB4.000000005CD12154.00006711
Received: by vm002.chost.de (sSMTP sendmail emulation); Tue, 07 May 2019 08:10:28 +0200
Date:   Tue, 7 May 2019 08:10:28 +0200
From:   Christoph Probst <kernel@probst.it>
To:     Steve French <smfrench@gmail.com>
Cc:     Pavel Shilovsky <pavel.shilovsky@gmail.com>,
        Jeremy Allison <jra@samba.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cifs: fix strcat buffer overflow in
 smb21_set_oplock_level()
Message-ID: <20190507061028.GP28577@netzpunkt.org>
References: <1557155792-2703-1-git-send-email-kernel@probst.it>
 <CAH2r5mtdpOvcE25P2UuNFpOwsNyFiBWRQELQFui+FJGVOOBV8w@mail.gmail.com>
 <20190506165658.GA168433@jra4>
 <CAH2r5msK6yNNm_QbdsFZuB5uS0iNRuqe8gSDKvVAiR0N6E3MWg@mail.gmail.com>
 <CAKywueR6DcfkzGcZUgydV4n6F4MKDEOvtCaM-gQSonX02tA9tg@mail.gmail.com>
 <CAH2r5ms+RAoe_1c=dUYL=yCs3KWAvqoB00-T4SEpyTjRKiwA6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <CAH2r5ms+RAoe_1c=dUYL=yCs3KWAvqoB00-T4SEpyTjRKiwA6A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steve French schrieb am 06.05.2019 um 23:18 Uhr:

> On Mon, May 6, 2019 at 2:03 PM Pavel Shilovsky
> <pavel.shilovsky@gmail.com> wrote:
> >
> > The patch itself is fine but I think we have a bigger problem here:
> 
> Good point.  Perhaps make update to the same patch to include both changes

I'll update my patch to implement the change suggested by Pavel.

I'll also switch the strcat to strncat and use strncpy in the "None"-case.

Regards,
Christoph



