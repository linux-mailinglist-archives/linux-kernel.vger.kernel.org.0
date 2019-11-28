Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6323610C12D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 01:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfK1A67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 19:58:59 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33100 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK1A67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:58:59 -0500
Received: by mail-lj1-f180.google.com with SMTP id t5so26544275ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JMQdYJyn4DZq+HXMjxQakd49p+RuvCwuEXKGIF9rqTI=;
        b=CKXOTnzsqF3gYIBfXgpG2e1jEoZEREkza8YXab/wIGjOSBN6lm9fxZzxJ+6sLmjfHR
         5sXfPEEzWMOoeCcR+jl6qOXeb0G11m4wnozanVJ/9AzpY6VQXRTLqlC7lL/W9YT8Gxof
         1fNHUuACF5y87/50eAvgibcSs1IJGl2tx2cmfK+fxg9YGpeMJQuJcVz7bchqapbWpiB8
         L4y3QgYRtezWYJ6l517p8TbYbVoJUA8ACnK5PIWXkQUyoDu4Gjq9wc1AVfJoreGsGVa+
         ouyqojKUw58BO5fEvVgHJGzR5X91PtpW4ClY6dxP2nP4PWhxDskigMBCK9YG0SUCBMLQ
         hKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JMQdYJyn4DZq+HXMjxQakd49p+RuvCwuEXKGIF9rqTI=;
        b=ORMo5tlIxI9KydLU5eN3iiE05KlD21P58BB1vy8/D0Io0EaSy+MRtInmZD/8eGvpzB
         RgLlYLfkZdxEo0ViHKytR+8t+9Fyj33CWwTpXY4etFLvxAdLWfXA5F66wUF3+iTWoCXu
         QdeGir2z65kkW3sgWLT5EhJWen/mqADPiVqKvVODd3hR85ewK6YiQtip2hFToPzl1m2Y
         lujgv4nJ3NMDbTwy1cnR/pe2XPH380wVlBquiuKdvM22YvVbc/Z5mr6SSW0ItdfBG531
         MZ6tEKpco1zSkcfthqikzBaXWzmkUMLpHH5faLmtemf7s2u4B4MoCHNC9iYI2P3cepM9
         GWGg==
X-Gm-Message-State: APjAAAVJplIy2gqjBoPSMXhdg1sCKCPyhZcqV6IG/fPA29eguXRIuuYx
        7BNF80kGzO3kwczFckYHUzRlBOGHTdu7rt9OTZiEZSK2
X-Google-Smtp-Source: APXvYqwbGShp1BUgqPdj19fDuf9/xuDKSywJyzHMDZf+TEcUVY3kE0qMicjWZxqnNGEt7kHsWot8b8W2mmVwT/SkImA=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr32743891ljq.40.1574902737179;
 Wed, 27 Nov 2019 16:58:57 -0800 (PST)
MIME-Version: 1.0
From:   Aaron Gray <aaronngray.lists@gmail.com>
Date:   Thu, 28 Nov 2019 00:58:41 +0000
Message-ID: <CANkmNDfhAF-j_ZSL6m-KAeeG2fO6BpSBEv=dTcEPCXSR1ziRpw@mail.gmail.com>
Subject: How to read BIOS'ES from IOMMU
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am interested in writing a program to verify BIOS integrity via
SHA512. Most modern BIOS'es seem to be accessible through IOMMU. I'm
wondering if there is a device driver for IOMMU or whether one could
be created for the purposes of accessing BIOS memory.

If anyone has any leads or advice or even can show me how to do this
in code via example/pseudo code I would appreciate it.

Regards,
Aaron

-- 
Aaron Gray

Independent Open Source Software Engineer, Computer Language
Researcher, Information Theorist, and amateur computer scientist.
