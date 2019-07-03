Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD845D667
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 14:47:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51730 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0p3rmkS+SSt76FLvKOCOdaTmlsp46pDKxMukz+MmNhw=; b=WWtvAKVNTSLO/KksdtC7MQH4Nc
        z09rCs/ZYlDFDJO3fjHjYgEqWQ6XNtb97OiY9xPjz6gG7U1bbof7r6SMTFlaconOVKjNU2cyAApeJ
        jiZBoBgWiOEEtgWbmISprR+vY3ASwCrEznvSyP7xpwo+K0BdXhnNQ1CAMwHRcRqECzJDXZOxJ9ePk
        eoc6glXyZWs4ArQUWJFCuZKNRSIJwQd2MpYeOWcKsuLj4gTerEVl7GSJKYG49FeteYy90omDN19Wz
        1BeHC2hhvNyCnie17Q72DLKpY0xRGJaSOyA8fBKhtNYwIOOzU9Nib2RvQzN8UkbNrwY9fOJApdssK
        Ktievoeg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiNo2-0000TC-CJ; Tue, 02 Jul 2019 18:47:06 +0000
Subject: Re: linux-next: Tree for Jul 2 (objtool)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190702195158.79aa5517@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0238309-72b4-1a5c-77ff-89c7e432e2ba@infradead.org>
Date:   Tue, 2 Jul 2019 11:47:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702195158.79aa5517@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 2:51 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190701:
> 

on x86_64:

kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x22: can't find switch jump table


-- 
~Randy
