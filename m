Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92154BB723
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440114AbfIWOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:50:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440102AbfIWOuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C6E3AFBF;
        Mon, 23 Sep 2019 14:50:37 +0000 (UTC)
Date:   Mon, 23 Sep 2019 16:50:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     yoav rubin <yoavrubin18@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: linux 32bit kernel virtual space , lowmem , highmem , RAM size
Message-ID: <20190923145037.GA1204@dhcp22.suse.cz>
References: <CAHcr5QqDCjWZz9ADvsE-3tt8qu4K+1NCn-gJuSsm2KBjUcaYVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHcr5QqDCjWZz9ADvsE-3tt8qu4K+1NCn-gJuSsm2KBjUcaYVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 19:46:46, yoav rubin wrote:
> Apologize in advance if I'm sending this to the wrong place. (It's my
> first time using mailing list...)
> 
> 
> I need some help understanding the exact relations between the linux
> kernel virtual space , specifically LOWMEM area , and the available
> RAM size as seen by the kernel.

Read through https://www.kernel.org/doc/gorman/

[...]
> For this question I'm ignoring the HIGHMEM area since its not exists
> in my system (turned it off by menuconfig).
[...]
> I know that I'm missing something here because there is no way its true.

If you disable highmem then all the 32b kernel can with is lowmem and
that is defined by the split (1/3 low/high).

-- 
Michal Hocko
SUSE Labs
