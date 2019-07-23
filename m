Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F0712EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbfGWHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:31:31 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:52098 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfGWHbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:31:31 -0400
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1hppGg-0000Pz-52; Tue, 23 Jul 2019 09:31:26 +0200
Date:   Tue, 23 Jul 2019 09:31:26 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next-20190722, imx25: Oops when loading a module
Message-ID: <20190723073126.yzein5pwgyha75hv@viti.kaiser.cx>
References: <20190722101312.2nakxrfy7yn4a4ro@viti.kaiser.cx>
 <20190722161307.GB4297@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722161307.GB4297@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

Thus wrote Jessica Yu (jeyu@kernel.org):

> Hi Martin,

> Thank you for reporting this. Could you please try the patch I posted here:

>  https://lore.kernel.org/lkml/20190722161006.GA4297@linux-8ccs/

> And let me know if that fixes the issue for you?

yes, your patch fixes the issue on my system. Thanks.

Tested-by: Martin Kaiser <martin@kaiser.cx>
