Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4570210CF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 21:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK1UFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 15:05:33 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59090 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1UFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 15:05:33 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8EA16200A6F;
        Thu, 28 Nov 2019 20:05:31 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 75CD7801CC; Thu, 28 Nov 2019 20:47:32 +0100 (CET)
Date:   Thu, 28 Nov 2019 20:47:32 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128194732.GA4702@owl.dominikbrodowski.net>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
 <20191128094419.GB17745@zn.tnic>
 <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
 <2859c017f515695eae1de47fdcf34db35bc5be39.camel@linux.intel.com>
 <20191128185607.GA3726@owl.dominikbrodowski.net>
 <20191128191218.GG17745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128191218.GG17745@zn.tnic>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:12:18PM +0100, Borislav Petkov wrote:
> On Thu, Nov 28, 2019 at 07:56:07PM +0100, Dominik Brodowski wrote:
> > Seems to work fine now. Thanks!
> 
> Does that mean I can add Reported-by: and Tested-by: you?

Srinivas Pandruvada already had added my Reported-by,[*] and you may extend
that by a Tested-by (or a combination thereof).

Thanks,
	Dominik

[*] https://lore.kernel.org/lkml/20191128150824.22413-1-srinivas.pandruvada@linux.intel.com/
