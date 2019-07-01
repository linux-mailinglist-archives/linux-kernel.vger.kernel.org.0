Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727891E829
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEOGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:11:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49786 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfEOGLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:11:53 -0400
X-IronPort-AV: E=Sophos;i="5.60,471,1549926000"; 
   d="scan'208";a="383210769"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 08:11:51 +0200
Date:   Wed, 15 May 2019 08:11:51 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [2/3] Coccinelle: pci_free_consistent: Reduce a bit of duplicate
 SmPL code
In-Reply-To: <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
Message-ID: <alpine.DEB.2.21.1905150811310.2591@hadrien>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de> <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de> <alpine.DEB.2.21.1905142146560.2612@hadrien> <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can different run time characteristics become relevant here?

Internally, they should be identical.

julia
