Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55D825864
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfEUThj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 15:37:39 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:54416 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfEUThj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:37:39 -0400
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0795919F58C;
        Tue, 21 May 2019 21:37:30 +0200 (CEST)
Subject: Re: [PATCH] dt: bindings: mtd: replace references to nand.txt with
 nand-controller.yaml
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <20f9a1cf-7779-434b-c589-d0ab9c4b481f@free.fr>
Date:   Tue, 21 May 2019 21:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 21:27, Kamal Dasu wrote:

> nand-controller.yaml replaced nand.txt however the references to it were
> not updated. This change updates these references wherever it appears in
> bindings documentation.
> 
> Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

You should coordinate with Mauro:

https://patchwork.kernel.org/patch/10951631/

Regards.
