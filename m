Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674F6910F7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHQO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 10:58:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43007 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfHQO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 10:58:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so4410237pgb.9;
        Sat, 17 Aug 2019 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnuNHe9aubRcZm/ceJk/Dq78R3sCq8agIg9M5WopPt8=;
        b=bVaPltO2r6SQqjVw0w0JXMwp2Y1P80xyi4uzOQR5poeTriQi0s/ZeYNnc80+57agnU
         MtJuMLFU7aj2Oc7S4B1KItW3HoG3AZny3oiKA9wspjwNhbpTsHHG3t7ea9UgLS7wZWha
         4i7yOIvDemrocfNbGt5E4AeV0fxHxKQNw6CV7FO2yWAbxUUQtVcJW0dgtUruks8WwMBx
         AnUjgN4d4jDe+cg52x0MXIlN4TdbftIBi7LA65vga4EIAy00fvui1lVVp4WkSoUoJGY9
         loq/fqjQ9P3NoINx/GjZbS6QB4kEphWYkJUUjP4rpzx35kRKZ9EW9OryTSSAN+8nYSgx
         TkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dnuNHe9aubRcZm/ceJk/Dq78R3sCq8agIg9M5WopPt8=;
        b=daN7ZHxxMCdo3eofV0AIz6cvv9WVM4Z/Ifo40Rt6OA/I+y7zh50T9Lxsk84Vk7UqEt
         CK5aE4GeVKWQeB7ig0OAsfnDpbtW1TTT/2axRpVraI11YaLesKpuECVOEPvzOcO22BVX
         NYBYG38PwdszBARIw3WsoE2oKcbzDXv8YDoCzhaYfJTBRvoj4RwWSfAhdXrskmfdqEGz
         MeC5KHs1+OQ5mKi84HJCXIObyPldnHnz0Wi7rKPqGF6vV9ipMaFD7wj5hCQd3/Qhxjrb
         x1vEq7MwdyzhQGDFd+DoWAgwuDULWzP8DHmk0I+gRTLqyVbyk9OPCzQiHC7ytZvnRoEk
         B1Rw==
X-Gm-Message-State: APjAAAVUUD+n/ndCTRBpmGxXxZNja7l7v/ONEp+6TVOCft/Q6l1RhBHa
        s6uWVRLYLrR5Hccuva5vTXcJiw7UWkk=
X-Google-Smtp-Source: APXvYqwP07iMq6zKJEIXYh8NBNC6LQJ9ieCaNG4Vfmvdw0ekTWVBQGmTqfGS5oLnZ3dxbKmYKo+gmg==
X-Received: by 2002:a62:7912:: with SMTP id u18mr16793996pfc.254.1566053886918;
        Sat, 17 Aug 2019 07:58:06 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.242])
        by smtp.gmail.com with ESMTPSA id g1sm9079805pgg.27.2019.08.17.07.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 07:58:06 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     joe@perches.com
Cc:     kernel-janitors@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: Re: [PATCH] clk: Remove extraneous 'for' word in comments
Date:   Sat, 17 Aug 2019 20:27:55 +0530
Message-Id: <1566053875-32322-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <74b4a00b524cf8dd11631692dee65ccbba34b8cb.camel@perches.com>
References: <74b4a00b524cf8dd11631692dee65ccbba34b8cb.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Joe for higlighting this. I am going
to send patches for them as well soon.
