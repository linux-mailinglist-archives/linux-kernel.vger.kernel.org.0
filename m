Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4564E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGJV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 17:59:16 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:51989 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbfGJV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:59:15 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id lKcIhy4HT0SBqlKcLh9umW; Wed, 10 Jul 2019 23:59:14 +0200
Message-ID: <a23e93d918f8be5aea4af0b87efbf9c3d143d2fb.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 23:59:11 +0200
In-Reply-To: <1562780135.3213.58.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
         <1562776339.3213.50.camel@HansenPartnership.com>
         <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
         <1562780135.3213.58.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMoDyKHtv+qWjJDzbcTFOrERD6em3puKBt2M4lUCiYiJx/xGdMeReMioNU0ggLYQNTpPnCIx9HEQfTITTRGIniN20GjPBg0mzfQTyyuHjQdtzG6W/MpE
 UL4RNuShVcIt7hcRy0cFn7jAEk+nnojvA/vjmFpWBgq4ArblnD/+VaH/C5uGzKiY+trNN4NcPbuZqwlGNRel6OynhtKqRbP4uBH+8+eAEtwsKbeY/KCQUSz8
 H67WcvjtTvesAOtdc1bBPj3zFcwkId/FvjdEylD1w5g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley schreef op wo 10-07-2019 om 10:35 [-0700]:
> I can get back to it this afternoon, when I'm done with the meeting
> requirements and doing other dev stuff.

I've started bisecting using your suggestion of that drm merge:
    $ git bisect log
    git bisect start
    # good: [89c3b37af87ec183b666d83428cb28cc421671a6] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
    git bisect good 89c3b37af87ec183b666d83428cb28cc421671a6
    # bad: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
    git bisect bad a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
    # bad: [ad2c467aa92e283e9e8009bb9eb29a5c6a2d1217] drm/i915: Update DRIVER_DATE to 20190417
    git bisect bad ad2c467aa92e283e9e8009bb9eb29a5c6a2d1217

Git told me I have nine steps after this. So at two hours per step I might
pinpoint the offending commit by Friday the 12th. If I'm lucky. (There are
other things to do than bisecting this issue.)

If you find that commit before I do, I'll be all ears.

Thanks,


Paul Bolle

