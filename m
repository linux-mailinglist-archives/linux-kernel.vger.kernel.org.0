Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4776119515B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 07:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0Ggq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 02:36:46 -0400
Received: from logand.com ([37.48.87.44]:46254 "EHLO logand.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0Ggq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:36:46 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 02:36:46 EDT
Received: by logand.com (Postfix, from userid 1001)
        id 7BAFA1AEE96; Fri, 27 Mar 2020 07:27:02 +0100 (CET)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 Q)
From:   Tomas Hlavaty <tom@logand.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct
In-Reply-To: <87v9p2tkut.fsf@logand.com>
References: <8736emquds.fsf@logand.com> <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com> <87immckp07.fsf@logand.com> <87v9p2tkut.fsf@logand.com>
Date:   Fri, 27 Mar 2020 07:26:51 +0100
Message-ID: <874kuapb2s.fsf@logand.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Hlavaty <tom@logand.com> writes:
>>> 2) Can you mount the corrupted(?) partition from a recent version of
>>> kernel ?

I tried the following Linux kernel versions:

- v4.19
- v5.4
- v5.5.11

and still get the crash
