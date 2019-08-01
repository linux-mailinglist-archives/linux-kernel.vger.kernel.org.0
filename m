Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0757DA2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfHALUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 07:20:02 -0400
Received: from mxserver10-out4.masterweb.com ([103.25.223.113]:49719 "EHLO
        mxserver10-out4.masterweb.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbfHALUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:20:02 -0400
X-Greylist: delayed 1907 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 07:20:00 EDT
Received: from [103.229.72.90] (helo=cl450110x.maintenis.com)
        by mxserver10.masterweb.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <fadil@dss-shipping.co.id>)
        id 1ht8Zl-0007JL-Bj; Thu, 01 Aug 2019 17:45:18 +0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dss-shipping.co.id; s=default; h=Message-ID:Reply-To:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pzHgJF3rUtdT9TR+nYNNAsjpO6LBjng0EyjCfnBe03c=; b=hzUOAjWGNoL7tjuro41FFJQl9V
        rtLFccL37PCdMXa5UeVDBxa1WCH9TEUuqyId5qRHhjhESOgyXNCpva25RTYRlVTQajrsNM7yooKlj
        G3lThaSHFoA6kAGIaFx9S+om1Aijc6KwNfojGAShliZgPt7gvuCCSk731OELDsAUGhkn9icd9RbA2
        TkFzEmB7TR0RIZSw3LsQTkteW/6qXnMz0H5DNYk0KQNDfG5RYvy6HPsFKu0B0UtycA/ziP/0wiGbc
        QU9hK6VAEx5cLzh0OBmQGmTO+KUBa/oGIXZ7EXfN3D8aygFOco6hKq8RIRbj69aH42a/bbWBJM97z
        5CfjjtcQ==;
Received: from [::1] (port=39234 helo=cl450110x.maintenis.com)
        by cl450110x.maintenis.com with esmtpa (Exim 4.92)
        (envelope-from <fadil@dss-shipping.co.id>)
        id 1ht8PS-0001od-LG; Thu, 01 Aug 2019 06:34:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Aug 2019 06:34:01 -0400
From:   ALBT <fadil@dss-shipping.co.id>
To:     undisclosed-recipients:;
Subject: Hallo
Reply-To: info.attltz244@gmail.com
Mail-Reply-To: info.attltz244@gmail.com
Message-ID: <8f0d034415c9e8393ee9154674d13a25@dss-shipping.co.id>
X-Sender: fadil@dss-shipping.co.id
User-Agent: Roundcube Webmail/1.3.8
X-Originating-IP: 103.229.72.90
X-MasterWebNetwork-Domain: cl450110x.maintenis.com
X-MasterWebNetwork-Username: 103.229.72.90
Authentication-Results: masterweb.com; auth=pass smtp.auth=103.229.72.90@cl450110x.maintenis.com
X-MasterWebNetwork-Outgoing-Class: unsure
X-MasterWebNetwork-Outgoing-Evidence: Combined (0.63)
X-Recommended-Action: accept
X-Filter-ID: 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
X-Report-Abuse-To: spam@mxserver1.masterweb.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

We have some grant on your familyname kindly Contact me here 
"{info.attltz244(at)gmail.com}" for more.

Regards,
Albrecht
