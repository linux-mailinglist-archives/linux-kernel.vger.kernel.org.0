Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C167415C683
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 17:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgBMQBR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Feb 2020 11:01:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:56746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbgBMQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:01:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 539D6B197;
        Thu, 13 Feb 2020 16:01:06 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:50:05 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200213155005.devifejlo3jxjzxo@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
 <20200210155611.lfrddnolsyzktqne@linux-p48b>
 <20200210143546.4491d9715f1c4a0a1de999ca@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200210143546.4491d9715f1c4a0a1de999ca@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020, Andrew Morton wrote:
>Measurable for microbenchmarks, I think?  But what benefit will a user
>see, running a workload that is cared about?

Well avoiding pointer chasing on large SMP systems has been shown to be
something we care about in the past. And yes my performance data comes
from an adhoc test scenario which only measures iteration latencies but
that doesn't mean there isn't value here.

Thanks,
Davidlohr
