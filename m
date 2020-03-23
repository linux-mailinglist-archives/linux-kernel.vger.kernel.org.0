Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7954518F06E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCWHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 03:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgCWHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB401AC11;
        Mon, 23 Mar 2020 07:49:45 +0000 (UTC)
Subject: Re: [PATCH 2/2] evtchn: Change evtchn port type to evtchn_port_t
To:     Yan Yankovskyi <yyankovskyi@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200323053503.GA1406@kbp1-lhp-F74019>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5b5c165b-aee3-7dde-f9f1-3a3de2e357a7@suse.com>
Date:   Mon, 23 Mar 2020 08:49:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323053503.GA1406@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2020 06:35, Yan Yankovskyi wrote:
> struct evtchn_set_priority uses uint32_t type for event channel port.
> Replace the type with evtchn_port_t. Such change is also done in Linux.
> 
> Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

As a general remark, the order of changes would better be the other way
around: The canonical header in the Xen repo be adjusted first, and the
change then propagated to repos carrying clones.

Thanks, Jan
