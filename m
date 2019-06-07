Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33A938E70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfFGPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 11:08:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfFGPIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD098AEB3;
        Fri,  7 Jun 2019 15:08:38 +0000 (UTC)
Subject: Re: [RFC PATCH 06/16] x86/xen: add shared_info support to xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-7-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <97d41abd-3717-1f78-4d5e-dfa74261e9c7@suse.com>
Date:   Fri, 7 Jun 2019 17:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> HYPERVISOR_shared_info is used for irq/evtchn communication between the
> guest and the host. Abstract out the setup/reset in xenhost_t such that
> nested configurations can use both xenhosts simultaneously.

I have mixed feelings about this patch. Most of the shared_info stuff we
don't need for the nested case. In the end only the event channels might
be interesting, but we obviously want them not for all vcpus of the L1
hypervisor, but for those of the current guest.

So I think just drop that patch for now. We can dig it out later in case
nesting wants it again.


Juergen
