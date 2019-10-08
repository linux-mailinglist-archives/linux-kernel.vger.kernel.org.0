Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7DD00F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJHTG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 15:06:58 -0400
Received: from gentwo.org ([3.19.106.255]:37640 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfJHTG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:06:57 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 0EC6A3EC01; Tue,  8 Oct 2019 19:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0BD213E886;
        Tue,  8 Oct 2019 19:06:57 +0000 (UTC)
Date:   Tue, 8 Oct 2019 19:06:57 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Kaitao Cheng <pilgrimtao@gmail.com>
cc:     akpm@linux-foundation.org, sashal@kernel.org, mhocko@suse.com,
        osalvador@suse.de, mgorman@techsingularity.net, rppt@linux.ibm.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        pavel.tatashin@microsoft.com, glider@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH] mm, page_alloc: drop pointless static qualifier in
 build_zonelists()
In-Reply-To: <20190927161416.62293-1-pilgrimtao@gmail.com>
Message-ID: <alpine.DEB.2.21.1910081906120.4398@www.lameter.com>
References: <20190927161416.62293-1-pilgrimtao@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019, Kaitao Cheng wrote:

> There is no need to make the 'node_order' variable static
> since new value always be assigned before use it.

In the past MAX_NUMMNODES could become quite large like 512 or 1k. Large
array allocations on the stack are problematic.

Maybe that is no longer the case?
