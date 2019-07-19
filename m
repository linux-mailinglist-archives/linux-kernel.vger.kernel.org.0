Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213AB6E694
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGSNg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 09:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:47334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727888AbfGSNg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC2A6AD33;
        Fri, 19 Jul 2019 13:36:54 +0000 (UTC)
Subject: Re: [PATCH 2/4] kernel-parameters.txt: Remove elevator argument
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
 <20190714053453.1655-3-marcos.souza.org@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <97b057c0-7930-d0a2-59ed-30ef73c645df@suse.de>
Date:   Fri, 19 Jul 2019 15:36:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714053453.1655-3-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/19 7:34 AM, Marcos Paulo de Souza wrote:
> This argument was not being used since the legacy IO path was removed,
> when blk-mq was enabled by default. So removed it from the kernel
> parameters documentation.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 6 ------
>   1 file changed, 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
