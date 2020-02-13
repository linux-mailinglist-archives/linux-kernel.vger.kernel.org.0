Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5039015C70A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgBMQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 11:06:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMQGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:06:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7368ACD7;
        Thu, 13 Feb 2020 16:06:20 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:55:20 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200213155520.bd332lzo4py27o5k@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
 <20200210155611.lfrddnolsyzktqne@linux-p48b>
 <20200211112015.GA4543@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200211112015.GA4543@sirena.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Mark Brown wrote:

>As I said in reply to the regmap patch I'm really unconvinced that any
>benefit will outweigh the increased memory costs for that usage.

I'm not arguing the regmap case; if it's not worth it it's not worth it.
With that conversion I was merely hoping that sync was used enough for
it to be considered.

Thanks,
Davidlohr
