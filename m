Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF4847F67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFQKOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 06:14:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfFQKOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:14:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 115B5AE65;
        Mon, 17 Jun 2019 10:14:50 +0000 (UTC)
Subject: Re: [RFC PATCH 15/16] xen/net: gnttab, evtchn, xenbus API changes
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-16-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <8b6cb452-f565-c515-cabb-068300ce3ef5@suse.com>
Date:   Mon, 17 Jun 2019 12:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-16-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> For the most part, we now pass xenhost_t * as parameter.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Same as previous patch.


Juergen
