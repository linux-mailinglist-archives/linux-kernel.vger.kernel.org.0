Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D39E23C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfH0IUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 04:20:50 -0400
Received: from mail-out.elkdata.ee ([185.7.252.64]:54660 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfH0IUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:20:49 -0400
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-out.elkdata.ee (Postfix) with ESMTP id 0A2F2372E21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:20:47 +0300 (EEST)
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 088B28308A1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:20:47 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay2.elkdata.ee ([185.7.252.69])
        by mail-relay2.elkdata.ee (mail-relay2.elkdata.ee [185.7.252.69]) (amavisd-new, port 10024)
        with ESMTP id 7fVVBfDpSn7V for <linux-kernel@vger.kernel.org>;
        Tue, 27 Aug 2019 11:20:44 +0300 (EEST)
Received: from mail.elkdata.ee (unknown [185.7.252.68])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 40A8C830886
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:20:44 +0300 (EEST)
Received: from mail.meie.biz (21-182-190-90.sta.estpak.ee [90.190.182.21])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id 3CCA560BF17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:20:44 +0300 (EEST)
Received: by mail.meie.biz (Postfix, from userid 500)
        id 24F7DA831CD; Tue, 27 Aug 2019 11:20:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566894044; bh=sSO9KbkfUa89G8QBfzT1Q305XqzYcN10D7TkyRQ3c2o=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=COILfj9/HvmMhM5ELdjKngEkCZQdDAX/hcyG+o4eeLQg8Nis80yjMSo+mveQGs5CQ
         rJzyjfZErcDKGrZtNj4rM/7lgeX2ws+dt29ke2Vn/w1QJ4FxSy3UVd6kv0gAlntqJR
         qc/psarAfOM/IQiz9gvC8vJFg2vMKGfqTvlN+uk4=
Received: from papaya (papaya-vpn.meie.biz [192.168.48.157])
        by mail.meie.biz (Postfix) with ESMTPA id 09B14A831CB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:20:44 +0300 (EEST)
Authentication-Results: mail.meie.biz; dmarc=fail (p=none dis=none) header.from=kraav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566894044; bh=sSO9KbkfUa89G8QBfzT1Q305XqzYcN10D7TkyRQ3c2o=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=COILfj9/HvmMhM5ELdjKngEkCZQdDAX/hcyG+o4eeLQg8Nis80yjMSo+mveQGs5CQ
         rJzyjfZErcDKGrZtNj4rM/7lgeX2ws+dt29ke2Vn/w1QJ4FxSy3UVd6kv0gAlntqJR
         qc/psarAfOM/IQiz9gvC8vJFg2vMKGfqTvlN+uk4=
Received: (nullmailer pid 10558 invoked by uid 1000);
        Tue, 27 Aug 2019 08:20:43 -0000
Date:   Tue, 27 Aug 2019 11:20:43 +0300
From:   Leho Kraav <leho@kraav.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: 5.3.0-rc6: i915 fails at typec_displayport 5120x1440
Message-ID: <20190827082043.GC4124@papaya>
References: <20190827080834.GB4124@papaya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827080834.GB4124@papaya>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:08:34AM +0300, Leho Kraav wrote:
> Hardware: Dell Latitude 7400 2-in-1, Whiskey Lake, Intel 620
> 
> 5120x1440 fails to display.

Looks like I'm not alone, either

https://www.reddit.com/r/linuxquestions/comments/cddpne/linux_and_ultrawide/
