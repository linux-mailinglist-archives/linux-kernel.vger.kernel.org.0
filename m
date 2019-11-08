Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4FF58E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfKHUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 15:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfKHUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:50:21 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26D221848;
        Fri,  8 Nov 2019 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573246221;
        bh=OOfOgjdTnHiIVSii5VijYiivZGhwtSVPMsSt7GnD7Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ViOdZiMbuBNy8pE7YhaAIDP481D18oATMd7FoCx8rxdDHi/lAA1CVdd/C6qBrJxP6
         t6zdoJ8a8q3INMK/39x7AzbWWCerkftISd3yKMxcNHIAi/Zsnow+ErdNt7XFF4+fSj
         cC1WzCPSAw3T2Lhn4ykCMpUEiviV+4XZAT4VbHAU=
Date:   Fri, 8 Nov 2019 12:50:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Yu Sun <yusun2@cisco.com>,
        xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] lib/xz: Fix XZ_DYNALLOC to avoid useless memory
 reallocations.
Message-Id: <20191108125020.3f927531189e9584f66adc10@linux-foundation.org>
In-Reply-To: <20191108202754.GG18744@zorba>
References: <20191108200040.20259-2-danielwa@cisco.com>
        <20191108202754.GG18744@zorba>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 12:27:54 -0800 Daniel Walker <danielwa@cisco.com> wrote:

> On Fri, Nov 08, 2019 at 12:00:40PM -0800, Daniel Walker wrote:
> > From: Lasse Collin <lasse.collin@tukaani.org>
> > 
> > s->dict.allocated was initialized to 0 but never set after
> > a successful allocation, thus the code always thought that
> > the dictionary buffer has to be reallocated.
> > 
> > For the original commit to xz-embedded.git, please refer to:
> > https://git.tukaani.org/?p=xz-embedded.git;a=commit;h=40d291b
> > 
> > Signed-off-by: Yu Sun <yusun2@cisco.com>
> 
> 
> Yu made me aware that Lasse had sent this on Nov. 4. I would recommend you
> take that patch, and disregard this one. Cisco is using it and we would like
> to see it merged.

No probs.  I'll take that as an acked-by ;)
