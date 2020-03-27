Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3111957A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgC0NCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 09:02:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33150 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgC0NCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:02:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 1294B297E16
Message-ID: <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 10:02:11 -0300
In-Reply-To: <20200327095029.GB11538@8bytes.org>
References: <20200323214956.30165-1-ezequiel@collabora.com>
         <20200327095029.GB11538@8bytes.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joerg,

Thanks for reviewing.

I understand this change bears some controversy
for IOMMU, as developers are probably used to see these
messages.

On Fri, 2020-03-27 at 10:50 +0100, Joerg Roedel wrote:
> On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> > These user messages are not really informational,
> > but mostly of debug nature. Lower their severity.
> 
> Like most other messages in the kernel log, that is not a reason to
> lower the severity.
>
> These messages are the first thing to look at when
> looking into IOMMU related issues.
> 

Sure, but the messages are still here, you can
always enable them when you are looking at IOMMU issues :-)

The idea is to reduce the amount of verbosity in the kernel.

If all subsystems would print messages that are useful
when looking at issues, things would be quite nasty verbose.

Thanks!
Ezequiel

