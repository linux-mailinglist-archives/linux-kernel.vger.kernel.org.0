Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704971E585
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 01:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfENXWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 19:22:11 -0400
Received: from mail.us.es ([193.147.175.20]:54854 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfENXWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:22:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 98767DA70A
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:22:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89425DA702
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:22:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7E297DA706; Wed, 15 May 2019 01:22:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8AEE3DA702;
        Wed, 15 May 2019 01:22:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 May 2019 01:22:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 697AC4265A31;
        Wed, 15 May 2019 01:22:06 +0200 (CEST)
Date:   Wed, 15 May 2019 01:22:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     Florian Westphal <fw@strlen.de>, shuah <shuah@kernel.org>,
        linu-kselftest@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
Message-ID: <20190514232206.cbbx5734z2eg4d5f@salvia>
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
 <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
 <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
 <c4660969-1287-0697-13c0-e598327551fb@kernel.org>
 <20190430100256.mfgerggoccagi2hc@breakpoint.cc>
 <20190430105225.bu5pil5fjxkltu4q@salvia>
 <CAG=yYw=YQzZQd-uyVXEgdTtLC9rpO5DE7SYW3hxQD3bVS8SD=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYw=YQzZQd-uyVXEgdTtLC9rpO5DE7SYW3hxQD3bVS8SD=g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 02:28:07AM +0530, Jeffrin Thalakkottoor wrote:
> Hi Pablo,
> 
> Please follow up on the mail you sent.
> This is for my interest to see my patch upstream

Please, pick a shorter patch subject, I'd suggest something like:

"selftests: netfilter: missing error check when setting up veth interface"

or alike.

Submit your v2 and don't forget to Cc: netfilter-devel@vger.kernel.org

Thanks.
