Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719B6FCB92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 18:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 12:14:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:55218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfKNROq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:14:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B100CACF1;
        Thu, 14 Nov 2019 17:14:44 +0000 (UTC)
Date:   Thu, 14 Nov 2019 18:14:43 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix regression caused by needless
 vmalloc_sync_all()
Message-ID: <20191114171443.GB21753@suse.de>
References: <20191113095530.228959-1-shile.zhang@linux.alibaba.com>
 <20191114135641.GA1356@dhcp22.suse.cz>
 <83a39694-373b-da16-3be1-22108ace0107@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a39694-373b-da16-3be1-22108ace0107@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:40:22PM +0800, Shile Zhang wrote:
> Could you please help to recall the original issue you encountered before?

The original issue was data corruption because old mappings did not get
removed from the vmalloc area, and thus also new mappings did not get
faulted in. So depending on the page-table currently loaded one
vmalloc/ioremap area pointed to different (often already freed or
re-used) memory and caused the corruption.

Regards,

	Joerg
