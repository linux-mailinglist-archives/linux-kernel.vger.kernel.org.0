Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA00364A97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfGJQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 12:17:05 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:34463 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727520AbfGJQRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:17:05 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id lFH7hw0M80SBqlFHAh8qoA; Wed, 10 Jul 2019 18:17:03 +0200
Message-ID: <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 18:16:57 +0200
In-Reply-To: <1562770874.3213.14.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLRIrnplNSIvUDH75sB5Ar/hqvTbGNDk2rvWbMiShmuIxyfdGCKqgqODhMwtXO6X65G1na/sP5swcZxIAvR+GPmc8amgh5MmNkFFvc1zw5GFDtmiRL1w
 ndxdR4vrhsm72dR+YZTyW9TKURvHVyThnQhIFZsUbjT8q/ucnxtoWy3avtrtl8Ta0N1Z+h6AMXSJKgr40HWhfKbWZq8yIwIAGGV1xSNqNqRCJ8Zm5HtyfzgH
 ZPzX2bHzuaNsu7ROx2dgnY0MvSykoiqgNxWwF+Cshus=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

James Bottomley schreef op wo 10-07-2019 om 08:01 [-0700]:
> I've confirmed that 5.1 doesn't have the regression and I'm now trying
> to bisect the 5.2 merge window, but since the problem takes quite a
> while to manifest this will take some time.  Any hints about specific
> patches that might be the problem would be welcome.

(Perhaps my message of yesterday never reached you.)

It seems I hit this problem quite easily. Bisecting v5.1..v5.2 could be a real
chore, so perhaps we could coordinate efforts (off-list)?

Thanks,


Paul Bolle

