Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7423004B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfE3Qns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 12:43:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:57494 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Qnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:43:47 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1D58728;
        Thu, 30 May 2019 16:43:46 +0000 (UTC)
Date:   Thu, 30 May 2019 10:43:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Joel Nider <joeln@il.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 00/10] Improvements to the documentation build system
Message-ID: <20190530104345.6c7184fe@lwn.net>
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 20:09:22 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> This series contain some improvements for the building system.
> 
> I sent already several of the patches here. They're rebased on the
> top of your docs-next tree:

The set is now applied...

> patch 1: gets rid of a warning since version 1.8 (I guess it starts
> appearing with 1.8.6);

This one I'd already picked up before.

> patches 2 to 4: improve the pre-install script;
> 
> patches 5 to 8: improve the script with checks broken doc references;
> 
> patch 9: by default, use "-jauto" with Sphinx 1.7 or upper, in order
> to speed up the build.

I put in the tweak we discussed here.

> patch 10 changes the recommended Sphinx version to 1.7.9. It keeps
> the minimal supported version to 1.3.
> 
> Patch 4 contains a good description of the improvements made at
> the build system. 

Thanks,

jon
