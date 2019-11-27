Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C410E10A7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0B1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:27:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfK0B1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ks8+NJHBfsPY3+JLhd/+2xG48ybtFps79bejbZJBn6w=; b=VM//JCOWuc5p7lONPOW3Oqp+X
        QCo+PObYUymI+92e5PEAjfv7QoaWLm9glA0CUVQ+pAIvGWP63KzP5j7xvUInggrd+6caJGOsIzQpA
        yUJgzwKLI9Nip9u4cszMbs/0pXYHLpZQcDEo/09eVG3crrEuH+qWjPelatvmftY30BdD/1YgRRpOA
        RH7U8iQvIauvJm0hWc1+nFzDNSfgxSZjXJTcK4W8/axASdIfEBEd036UTIU3It4vDlgAwshwDoRFD
        a+prhKxg//kMM2OgfWhKFhN7B7QZEbgcCvBQmcIeefvvqA3A7/iq3FDtauqx6Sryzvmew+R2AJCD5
        13tK0CRjg==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZm6o-0001e3-Bp; Wed, 27 Nov 2019 01:27:10 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: m68k Kconfig warning
Message-ID: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
Date:   Tue, 26 Nov 2019 17:27:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Just noticed this.  I don't know what the right fix is.
Would you take care of it, please?

on Linux 5.4, m68k allmodconfig:

WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
  Depends on [n]: DISCONTIGMEM [=n] || NUMA
  Selected by [y]:
  - SINGLE_MEMORY_CHUNK [=y] && MMU [=y]


thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
