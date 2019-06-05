Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1806235F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfFEOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 10:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728369AbfFEOWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6684AFC7;
        Wed,  5 Jun 2019 14:22:47 +0000 (UTC)
Date:   Wed, 5 Jun 2019 16:22:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605142246.GH15685@dhcp22.suse.cz>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
 <20190605070312.GB15685@dhcp22.suse.cz>
 <20190605130727.GA25529@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605130727.GA25529@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-06-19 18:37:28, Bharath Vedartham wrote:
> [Not replying inline as my mail is bouncing back]
> 
> This patch is based on reading the code rather than a kernel crash. My
> thought process was that if an invalid node id was passed to
> __alloc_pages_node, it would be better to add a VM_WARN_ON and fail the
> allocation rather than crashing the kernel. 

This makes some sense to me because BUG_ONs are usually a wrong way to
handle wrong usage of the API. On the other hand VM_BUG_ON is special in
the way that production although some distributions enable it by default
IIRC.

> I feel it would be better to fail the allocation early in the hot path
> if an invalid node id is passed. This is irrespective of whether the
> VM_[BUG|WARN]_*s are enabled or not. I do not see any checks in the hot
> path for the node id, which in turn may cause NODE_DATA(nid) to fail to
> get the pglist_data pointer for the node id. 
> We can optimise the branch by wrapping it around in unlikely(), if
> performance is the issue?

unlikely will just move the return NULL ouside of the main code flow.
The check will still be done.

> What are your thoughts on this? 

I don't know. I would leave the code as it is now or remove the
VM_BUG_ON. I do not remember this would be catching any real issues in
the past.
-- 
Michal Hocko
SUSE Labs
