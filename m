Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861261AC44
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfELNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 09:01:53 -0400
Received: from sydney7.cnglobal.com.au ([182.160.167.150]:43878 "EHLO
        sydney7.cnglobal.com.au" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbfELNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 09:01:52 -0400
X-Greylist: delayed 3338 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 May 2019 09:01:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailboxesr-us.com.au; s=default; h=Message-ID:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IHKMEDdNGmA9Pdgc9B7HQdaWw0UDqD6Dt1MbJsVGRG0=; b=LvSdGx/kh9pVj2D46dP8AveUU
        /sJnH4Oj4UxuACIYhzETjzBK5umEoix31DdBKN2ZXeq8trjt+VFWnMGRBei0q9XgsIwwaMl+Xsgq7
        U0EncUayQRMbjLokQ5i40Wi0PZZ77sGJpV9QcL1DDJJ7IZnSF0rjpDhMd8bnkRXZDJeIU=;
Received: from [127.0.0.1] (port=34144 helo=sydney7.cnglobal.com.au)
        by sydney7.cnglobal.com.au with esmtpa (Exim 4.91)
        (envelope-from <sam@difava.com.au>)
        id 1hPmF9-006nsi-TP; Sun, 12 May 2019 21:02:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 May 2019 21:02:05 +1000
From:   Sam Di Fava <sam@difava.com.au>
To:     undisclosed-recipients:;
Subject: Re:
Message-ID: <0912a5b7db7d5bc7e7235fe7cd4ea474@difava.com.au>
X-Sender: sam@difava.com.au
User-Agent: Roundcube Webmail/1.3.7
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sydney7.cnglobal.com.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - difava.com.au
X-Get-Message-Sender-Via: sydney7.cnglobal.com.au: authenticated_id: mailboxesrus@mailboxesr-us.com.au
X-Authenticated-Sender: sydney7.cnglobal.com.au: mailboxesrus@mailboxesr-us.com.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r
