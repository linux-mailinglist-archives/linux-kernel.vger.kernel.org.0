Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C43A414
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfFIHBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 03:01:23 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:39746 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:01:22 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 32BDE200700;
        Sun,  9 Jun 2019 07:01:21 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D587021831; Sun,  9 Jun 2019 08:59:48 +0200 (CEST)
Date:   Sun, 9 Jun 2019 08:59:48 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 19/33] docs: pcmcia: convert docs to ReST and rename
 to *.rst
Message-ID: <20190609065948.GA25429@light.dominikbrodowski.net>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <d1b05720154bdbc4b75f5583cd4d1740e58b4cde.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b05720154bdbc4b75f5583cd4d1740e58b4cde.1560045490.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 11:27:09PM -0300, Mauro Carvalho Chehab wrote:
> Convert the pcmcia docs to ReST format. Most of the changes here
> are trivial.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
