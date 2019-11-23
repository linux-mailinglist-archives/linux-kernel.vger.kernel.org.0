Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE841080C7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfKWVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 16:20:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWZCIitMdTt18c/AfFpGc85KaZDw3UDYsWgRXFn2ZUc=; b=Ef1uV4K8PQwW0V3wzMU8X4qv9
        GicKKAos0LRU/xliHJquGpVAstmxN8pPyfJnrnnf7jtwDyKd0yz574HF6BwVyC4pzjnofBKIEcrX0
        K8ymLj5b6+lAufsf+5eLE86FgOTK4X4Wqrr+8mnKruEB/2YjVgMdf2IaJGtzVNEzNql5NXHQZ8dZf
        l+XBrHogsDkcTUXtRzpxgmtyt1zOo6nyTvkas2d4FYacCB5uF6WQvxfK6HREPo7haA6cozNlC/6M+
        3O/7MO8svNARcfhFDNP4WzRZ9OThPLOUsubuKalZHf/AU/hupfAgfJ2/kof0U5cL8ERgSzXCRWp5/
        6H5fc9RfQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYcp8-0003CN-2C; Sat, 23 Nov 2019 21:20:10 +0000
Subject: Re: [PATCH 0/3] init/main.c: minor cleanup/bugfix of envvar handling
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
References: <20191123210808.107904-1-nivedita@alum.mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c209b9af-2352-f476-d32a-ae761d8f709a@infradead.org>
Date:   Sat, 23 Nov 2019 13:20:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191123210808.107904-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/19 1:08 PM, Arvind Sankar wrote:
> unknown_bootoption passes unrecognized command line arguments to init as
> either environment variables or arguments. Some of the logic in the
> function is broken for quoted command line arguments.
> 

Hi,

You will need to send your patches to some maintainer who could merge them.
Nobody browses LKML to pick up patches (other than bots).

See Documentation/process/submitting-patches.rst: section 5:
5) Select the recipients for your patch
---------------------------------------

for more info.

-- 
~Randy

