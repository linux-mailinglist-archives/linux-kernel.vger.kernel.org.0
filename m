Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A58D112E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfJIO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 10:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfJIO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:26:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7364CAD2C;
        Wed,  9 Oct 2019 14:26:23 +0000 (UTC)
Date:   Wed, 9 Oct 2019 16:26:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Qian Cai <cai@lca.pw>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191009142623.GE6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 15:56:32, Peter Oberparleiter wrote:
[...]
> A generic solution would be preferable from my point of view though,
> because otherwise each console driver owner would need to ensure that any
> lock taken in their console.write implementation is never held while
> memory is allocated/released.

Considering that console.write is called from essentially arbitrary code
path IIUC then all the locks used in this path should be pretty much
tail locks or console internal ones without external dependencies.
Otherwise we are in a whack a mole situation chasing very complex lock
chains.
-- 
Michal Hocko
SUSE Labs
