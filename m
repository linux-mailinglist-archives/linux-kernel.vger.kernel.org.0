Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E2E4AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504223AbfJYMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:11:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409923AbfJYMLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:11:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BF6DB21D;
        Fri, 25 Oct 2019 12:11:05 +0000 (UTC)
Date:   Fri, 25 Oct 2019 14:11:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025121104.GH17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025120505.GG17610@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 14:05:05, Michal Hocko wrote:
[...]
> This smells like something that could be runtime specific. Could you
> post strace output of your testcase?

Ohh and /proc/<pid>/smaps while the strace is hung on mlockall please.
-- 
Michal Hocko
SUSE Labs
