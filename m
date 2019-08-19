Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2878692131
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfHSKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 06:19:59 -0400
Received: from correo.us.es ([193.147.175.20]:49246 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfHSKT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:19:58 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 57D4AA8211
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:19:55 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 49CF0B8004
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:19:55 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3F7C0B7FF6; Mon, 19 Aug 2019 12:19:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4AC1DDA72F;
        Mon, 19 Aug 2019 12:19:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 19 Aug 2019 12:19:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.181.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F11244265A2F;
        Mon, 19 Aug 2019 12:19:52 +0200 (CEST)
Date:   Mon, 19 Aug 2019 12:19:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Juanjo Ciarlante <jjciarla@raiz.uncu.edu.ar>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove IP MASQUERADING record
Message-ID: <20190819101951.yoc73dhyzpt6hxd2@salvia>
References: <20190813085818.4yfcaxfk2xqy32fx@salvia>
 <20190814123502.12863-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814123502.12863-1-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:35:02PM +0300, Denis Efremov wrote:
> This entry is in MAINTAINERS for historical purpose.
> It doesn't match current sources since the commit
> adf82accc5f5 ("netfilter: x_tables: merge ip and
> ipv6 masquerade modules") moved the module.
> The net/netfilter/xt_MASQUERADE.c module is already under
> the netfilter section. Thus, there is no purpose to keep this
> separate entry in MAINTAINERS.

Applied, thanks.
