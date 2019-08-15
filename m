Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74B38F6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfHOWMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 18:12:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CS1ls6fq54lREgwpnKLgVGit1qnhnnyNRdGhQ3qigkg=; b=GlWiNQ+LLSaNEkZ0BtXZ+duZ7
        +wAVJ8xYVOA2PT3bcgaKgpvarmXa3aaKlXWhLa17eINI2gLof1x1+CDNfGVXJ8aBbYVxwZDggtDDg
        hFGXiEnjjev2s03n/ij0hZ94oF6WKYjXcHj3xdIsxga4iiSKqQW91gvhVwvL9E4a5KBiBGpRYBKgG
        QO6h69iijBSguBdWVGTFDyRLioWNjiQzKewAsDRnrh1ZW2VMIa6J3Trfs1C10z4KlxlJODYiztaZt
        grtia0YECRIdf2kYntNWkXqlNOFH1pg0v4uHfWxy8hDmTYJDGWy4iI3Y64gDPY52PzRvBLc+egKra
        6z7/JCLqA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyNz3-0006jw-Cr; Thu, 15 Aug 2019 22:12:37 +0000
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20190725130113.GA12932@kroah.com>
 <20190725151302.16a3e0e3@lwn.net> <20190815212019.GB12041@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3ae0d66-b9eb-97ba-647a-57f3e2eb4af2@infradead.org>
Date:   Thu, 15 Aug 2019 15:12:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815212019.GB12041@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 2:20 PM, Greg Kroah-Hartman wrote:
>>> +The hardware security team will provide a per incident specific encrypted
>> s/per incident specific/incident-specific/
> Fixed.  And changed /a/ to /an/

eh?  still should be /a per incident/

-- 
~Randy
