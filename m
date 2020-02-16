Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017E3160167
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 03:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBPCKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 21:10:43 -0500
Received: from gw.cm.dream.jp ([59.157.128.2]:43681 "EHLO vsmtp01.cm.dti.ne.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgBPCKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 21:10:42 -0500
Received: from localhost (KD124210025232.ppp-bb.dion.ne.jp [124.210.25.232]) by vsmtp01.cm.dti.ne.jp (3.11v) with ESMTP AUTH id 01G2AUCE000648;Sun, 16 Feb 2020 11:10:36 +0900 (JST)
Date:   Sun, 16 Feb 2020 11:10:29 +0900 (JST)
Message-Id: <20200216.111029.687350152614907818.hermes@ceres.dti.ne.jp>
To:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_construct
From:   ARAI Shun-ichi <hermes@ceres.dti.ne.jp>
In-Reply-To: <20200210.224609.499887311281343618.hermes@ceres.dti.ne.jp>
References: <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com>
        <20200123.225827.1155989593018204741.hermes@ceres.dti.ne.jp>
        <20200210.224609.499887311281343618.hermes@ceres.dti.ne.jp>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And,

In <20200210.224609.499887311281343618.hermes@ceres.dti.ne.jp>;
   ARAI Shun-ichi <hermes@ceres.dti.ne.jp> wrote
   as Subject "Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct":

> Hi,
> 
> FYI, reporting additional test results.
> 
> I reproduced this problem with clean NILFS2 fs in previous mail.
> "clean" means that "make filesystem before every tests."
> In this mail, I tried to reproduct with/without VG/LV, LUKS, loopback.
> 
> * Not reproduced
>  USB stick - primary partition - NILFS2
>  USB stick - primary partition - VG/LV - NILFS2
>  USB stick - primary partition - VG/LV - LUKS - NILFS2
>  USB stick - primary partition - LUKS - VG/LV - NILFS2
>  USB stick - primary partition - LUKS - VG/LV - LUKS - NILFS2
>  /tmp (tmpfs) - regular file - NILFS2 (loopback mount, kernel 4.19.82)
>  USB stick - primary partition(512MiB) - NILFS2
> 
> * Reproduced (always, immediately)
>  /tmp (tmpfs) - regular file - NILFS2 (loopback mount)
>  USB stick - primary partition - ext4 - regular file - NILFS2 (loopback mount)

this loopback problem is seen in Kernel 5.5.4.

> Test conditions:
>  kernel 4.19.86 (same as previous test)
>  NILFS2/ext4 filesystem, VG/LV, LUKS were made with default parameters
>  size of "primary partition" in USB stick is approx. 14GiB
>  size of "regular file" is approx. 512MiB
>  "reproduce": mount NILFS2, touch file, sync
