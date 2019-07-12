Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE367563
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfGLTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 15:31:32 -0400
Received: from mxserver5-out5.masterweb.com ([103.25.223.54]:53897 "EHLO
        mxserver5-out5.masterweb.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfGLTbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:31:32 -0400
X-Greylist: delayed 12718 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 15:31:29 EDT
Received: from [45.64.1.95] (helo=cl46075x.maintenis.com)
        by mxserver5.masterweb.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <infoagywest@ptkbspro.com>)
        id 1hlxx7-00042D-Cd; Fri, 12 Jul 2019 22:59:25 +0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ptkbspro.com; s=default; h=MIME-Version:Content-Type:Subject:To:From:
        Message-ID:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mX8m69JJS9POGuCwnYwM5p8xiCDpNnfsgHOzo/kb9NE=; b=L/b+MHYaMZX2h1ZyVh4DxdM/7q
        BtpBZu0rL4fDDeR5Qn7n2EiE93h280AkWzkjt2bfY704IfxyvDFk2hgEWZ/3XvtkmkHY0jx0oFylO
        bub1WgWn1QB2qpLbusBkNxD9KIPjwQPpIyKOj0hE2/VqdpHYZrEsSsjaxYtMfRQ0XSf/2wZrgABzS
        zjLRrDzIomV5DKNzKGxv6ugZH8j0PU+50tUy9jomIPmRu057FWKIU4wxtQwY3QhEvx7uBcHVLwuft
        esEquVTj14oxz8IYrpVkQlgBbmv/ahH1rUSGYX98mANJnwibs9Iu+NkhrShrh4j9uE0LFYZ5wj7Wq
        PMqv2Bsw==;
Received: from [::1] (port=42752 helo=cl46075x.maintenis.com)
        by cl46075x.maintenis.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <infoagywest@ptkbspro.com>)
        id 1hlxwu-0008Hq-SA; Fri, 12 Jul 2019 11:59:04 -0400
Received: from [41.203.78.21] ([41.203.78.21]) by demo.ptkbspro.com (Horde
 Framework) with HTTPS; Fri, 12 Jul 2019 11:59:04 -0400
Date:   Fri, 12 Jul 2019 11:59:04 -0400
Message-ID: <20190712115904.Horde.oFkixyY6jXHgkjjBC5niJCy@demo.ptkbspro.com>
From:   infoagywest@ptkbspro.com
Subject: Your Over-due Fund
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Originating-IP: 45.64.1.95
X-MasterWebNetwork-Domain: cl46075x.maintenis.com
X-MasterWebNetwork-Username: 45.64.1.95
Authentication-Results: masterweb.com; auth=pass smtp.auth=45.64.1.95@cl46075x.maintenis.com
X-MasterWebNetwork-Outgoing-Class: unsure
X-MasterWebNetwork-Outgoing-Evidence: Combined (0.73)
X-Recommended-Action: accept
X-Filter-ID: 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
X-Report-Abuse-To: spam@mxserver1.masterweb.com
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sir/Ma,

This is to notify you that your long awaited funds is ready for claim.
Your name attached to claim file Code HBLK-027-FB06/19 has been  
approved and ready for disbursement.

To process your funds you are expected to reply with the attached file  
code: HBLK-027-FB06/19, your name, contact address and telephone  
number for quick attestation of your file within the next 72 hours as  
the payment rules stipulates to avoid penalty.

CONTACT PAYMENT OFFICER: Rev. John Bettison via his official E-mail:  
rev.johnbettison@outlook.com

Yours truly,

Mrs. Agnes Westman

Head Of United Nations Under-Secretary-
General For Internal Oversight Services.




