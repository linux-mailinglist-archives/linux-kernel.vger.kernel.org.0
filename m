Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C114E60429
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfGEKKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Jul 2019 06:10:50 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52275 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfGEKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:10:50 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 85CE1C0002;
        Fri,  5 Jul 2019 10:10:44 +0000 (UTC)
Date:   Fri, 5 Jul 2019 12:10:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: DT bindings vendor prefixes file yas been
 translated into yaml
Message-ID: <20190705121043.4d1b903e@xps13>
In-Reply-To: <20190705100345.29269-1-miquel.raynal@bootlin.com>
References: <20190705100345.29269-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Fri,  5 Jul 2019
12:03:45 +0200:

> The extension is now .yaml instead of .txt.
> 
> Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

I am one month too late, didn't saw it was fixed in linux-next (as well
as the vendors prefix research), sorry for the noise.

Kind regards,
Miquèl
