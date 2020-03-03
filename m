Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B658C177146
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgCCIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 03:30:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCIaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:30:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ADABEB1FB;
        Tue,  3 Mar 2020 08:30:17 +0000 (UTC)
Subject: Re: [PATCH] xen: Use 'unsigned int' instead of 'unsigned'
To:     Yan Yankovskyi <yyankovskyi@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200229223035.GA28145@kbp1-lhp-F74019>
 <fba833c4-3173-0094-b4ec-53e9f42bfb3e@suse.com>
 <20200302221826.GA18206@kbp1-lhp-F74019>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <38739aa0-200e-fd46-ea38-c30a6aa69561@suse.com>
Date:   Tue, 3 Mar 2020 09:30:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302221826.GA18206@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.2020 23:18, Yan Yankovskyi wrote:
> On Mon, Mar 2, 2020 at 10:11 Jan Beulich wrote:
>> ... evtchn_port_t here and elsewhere.
> 
> There are some interfaces with signed int as a type for port, e.g. in
> include/xen/events.h.
> Should I create additional patch to resolve inconsistency with evtchn
> interface?
> Or you suggest combining these changes into the existing patch?

Signed <-> unsigned conversions would perhaps better go into a
separate patch. But note I'm not the maintainer of this code.

> Also as I understand 'evtchn' and 'port' are essentially the same
> entities from perspective of local domain, related to each other roughly
> like connection and file descriptor pair. What do you think about
> renaming all 'evtchn' arguments and variables to 'port'?
> It will eliminate inconsistencies in the code, for example
> in include/xen/interface/event_channel.h and include/xen/events.h.

I'd welcome this, but the maintainers will have the final say.

Jan
