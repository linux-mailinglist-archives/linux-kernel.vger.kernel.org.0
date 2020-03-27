Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A4C196105
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgC0WZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgC0WZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A3857296825
Message-ID: <761b5165f6708bb707148cfdee13d9b710eef29c.camel@collabora.com>
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 19:25:27 -0300
In-Reply-To: <6db3bcfb-c778-7190-a936-836eaba4bb73@arm.com>
References: <20200323214956.30165-1-ezequiel@collabora.com>
         <20200327095029.GB11538@8bytes.org>
         <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
         <6db3bcfb-c778-7190-a936-836eaba4bb73@arm.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-27 at 18:04 +0000, Robin Murphy wrote:
> On 2020-03-27 1:02 pm, Ezequiel Garcia wrote:
> > Hello Joerg,
> > 
> > Thanks for reviewing.
> > 
> > I understand this change bears some controversy
> > for IOMMU, as developers are probably used to see these
> > messages.
> > 
> > On Fri, 2020-03-27 at 10:50 +0100, Joerg Roedel wrote:
> > > On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
> > > > These user messages are not really informational,
> > > > but mostly of debug nature. Lower their severity.
> > > 
> > > Like most other messages in the kernel log, that is not a reason to
> > > lower the severity.
> > > 
> > > These messages are the first thing to look at when
> > > looking into IOMMU related issues.
> > > 
> > 
> > Sure, but the messages are still here, you can
> > always enable them when you are looking at IOMMU issues :-)
> 
> That still begs the question of who "you" is and how they know they're 
> debugging an IOMMU issue in the first place. When all the developer has 
> to go on is a third-hand bugzilla attachment from a distro user's vague 
> report of graphics corruption/poor I/O performance/boot 
> failure/whatever, being able to tell straight away from a standard dmesg 
> dump whether an IOMMU is even in the picture or not saves a lot of 
> protracted back-and-forth for everyone involved.
> > The idea is to reduce the amount of verbosity in the kernel.
> 
> Under what justification? Users with slow consoles or who just want a 
> quiet boot are already free to turn down the loglevel; a handful of 
> messages at boot-time and device hotplug seem hardly at risk of drowning 
> out all the systemd audit spam anyway. Note that the IOMMU subsystem is 
> by nature a little atypical as a lot of what it does is only visible as 
> secondary effects on other drivers and subsystems, without their 
> explicit involvement or knowledge. In that respect, hiding its activity 
> can arguably lead to more non-obvious situations than many other subsystems.
> 
> > If all subsystems would print messages that are useful
> > when looking at issues, things would be quite nasty verbose.
> 
>  From a personal standpoint, can we at least eradicate all the "Hi! I'm 
> a driver/subsystem you don't even have the hardware for!" messages 
> first, then maybe come back and reconsider the ones that convey actual 
> information later?
> 

Do we really still have those???

Thanks,
Ezequiel

