Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84F17CC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfGaSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 14:51:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:55586 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfGaSv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:51:26 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EE7997DA;
        Wed, 31 Jul 2019 18:51:25 +0000 (UTC)
Date:   Wed, 31 Jul 2019 12:51:24 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: translations for documents in process/
Message-ID: <20190731125124.46e06ab6@lwn.net>
In-Reply-To: <20190728092054.1183-1-federico.vaga@vaga.pv.it>
References: <20190728092054.1183-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019 11:20:54 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> From: Alessia Mantegazza <amantegazza@vaga.pv.it>
> 
> Translations for the following documents in process/:
>     - email-clients
>     - management-style
> 
> Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

This looks generally good, but I have to ask...

> +Se la patch che avete inserito dev'essere modificata usato la finestra di
> +scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
> +disabilitata :menuselection:`Configurazione-->Preferenze-->Composizione-->Interruzione riga`.

Have you actually verified that the translations used in these mail
clients matches what you have here?

Thanks,

jon
