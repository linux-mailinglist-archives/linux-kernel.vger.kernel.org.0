Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C68CF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHNJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:12:05 -0400
Received: from mx1.riseup.net ([198.252.153.129]:58372 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfHNJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:12:04 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id D67AC1B91B1;
        Wed, 14 Aug 2019 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1565773922; bh=oW9fbXdkjx9OcEYJVruSc0eYgJA1NnILKtEzwNxUvIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
        b=IewXAZIFcj0DVjhSQ9klLUWPW5KnV+DCfwG2fSiwFjE3zPrUEHzrg9LAmj3dmnPXW
         XyF0fZQeWxywgXbUrfsiQQd21GRM2O7+elA03F0CTiXrgTvrMgadc995/Y57iW2BDu
         MfGwLc9p2MGcWoIGknK/mwBrBFBKvf7ueacOZn4k=
X-Riseup-User-ID: D21A026486371A7AB26BE3B4C633D8C2FAE9D2EA9EAA6509300DB21F4C84058E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 17CB71202AD;
        Wed, 14 Aug 2019 02:12:00 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:11:54 +0300
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Cc:     mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190814121154.12f488f7@localhost>
In-Reply-To: <20190814070457.GA26456@zn.tnic>
References: <20190813232829.3a1962cc@localhost>
 <20190813212115.GO16770@zn.tnic>
 <20190814010041.098fe4be@localhost>
 <20190814070457.GA26456@zn.tnic>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 09:04:57 +0200 Borislav Petkov wrote:

> IMO, what you want does not belong in sysfs but in documentation.

How would documentation (a fixed static text file) tell whether a
particular system is vulnerable or not?

> I partially see your point that a table of sorts mapping all those CPU
> vulnerability names to (possible) mitigations is needed for users
> which would like to know whether they're covered, without having to
> run some scripts from github,

Correct.

> but sysfs just ain't the place.

Then why is it currently used for some of the vulnerabilities?

I am not an expert and I don't know if it is the place. My only concern
is to have that information which we currently don't regardless of
where it may be placed.
