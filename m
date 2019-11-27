Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC910B32A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0Q0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 11:26:12 -0500
Received: from gentwo.org ([3.19.106.255]:39458 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0Q0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:26:12 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id DCF9B3EF16; Wed, 27 Nov 2019 16:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id DC2BB3EC1C;
        Wed, 27 Nov 2019 16:26:11 +0000 (UTC)
Date:   Wed, 27 Nov 2019 16:26:11 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
In-Reply-To: <20191127162400.GT20912@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911271625110.17727@www.lameter.com>
References: <20191126121901.GE20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911261632030.9857@www.lameter.com> <20191126165420.GL20912@dhcp22.suse.cz> <alpine.DEB.2.21.1911271535560.16935@www.lameter.com> <20191127162400.GT20912@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019, Michal Hocko wrote:

> Would you mind a patch that would add a kernel command line parameter
> that would work like memcg_sysfs_enabled? The default for the config
> would be on. Or it would be preferrable to simply drop only events?

Just drop the events may be best. Then we know if someone is using it.

