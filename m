Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD8164519
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 14:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBSNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 08:13:49 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36876 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:13:48 -0500
Received: by mail-wm1-f44.google.com with SMTP id a6so614490wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 05:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:mime-version:content-disposition;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=n6NLB2/bwkDjR09TXStkKvPt8CjAZbubV+a6FYItKGTZox2/7wzyuD20y0ItKce6oU
         xTWcdKVCwBgGv8oorvcxPfqwsnekA4fdMPclBPMstIgnJ0QOaJ/H5ZXQEYQr0N2AqoL7
         +f1exWjZVhO9PY2lCkOsffc/GZTWgDW2jgsEOOIffxImq+ndXxliwQZLnAnRNNVFaiwj
         hSDRbObN4wnwLU/vec1/jUnDxQ8kai4exe/LViXuaTqzYGQPD83hjMasteumWBatB6GH
         x1t8xAWvBetw8lApncJnRmOG8kkoELLlq+bKZ73pSbDIPp9rJ8oEAwX05G8qGgv2THwQ
         yMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:mime-version
         :content-disposition;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=XWg6ph4vpm3MhvNnxaJpSzvbofuyMuh2jSyEF5Msjuysyp1yQtMmFPVAUctkT2/k3g
         3riLTkmtyyGIVj4WhBIA0rwLcD7suT0OmFyGJak919ZD+++16JG5f8CJXlup4+Sg0LPT
         33GeZvpr4AUUgHHJOO5/29dyQzSGmVxR3EHvy48BS1nTSJjL4bBcFXRTPknxgDsv2bsX
         tgnwaAPVgbwNeST79HH5+ejm7Lya7rr9OnZifXz8eV30U/1Mx1YMLWyjV2NgakpzTcnC
         oWKM2CB0QxmmTs7z2ANPGedeT5wmYMpgWgwu8Atpm4jsTE6vsi3xI1PDVXSXdGJy1yp6
         /YXQ==
X-Gm-Message-State: APjAAAX4L8DEHaQ7ZPNbcoYnOxxs9QZI13emZESt/1KuXagrCoyRPEQX
        vHTWFl0CxBBBNRjCy9zZeACmGYI9Dxw=
X-Google-Smtp-Source: APXvYqz4crJkzAYQpSKEa12pTCC09R/2lg0azD1/8j3NFCONEsO0mq6trl8eIIQCfIM9FQogpTI8OA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr10017714wmg.20.1582118025772;
        Wed, 19 Feb 2020 05:13:45 -0800 (PST)
Received: from Orgrimmar.local ([82.16.192.227])
        by smtp.gmail.com with ESMTPSA id d4sm3091795wra.14.2020.02.19.05.13.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:13:45 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:13:43 +0000
From:   =?iso-8859-1?Q?Eth=E2n?= ap Paul <epmorkernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <20200219131343.GA42579@Orgrimmar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subscribe linux-kernel
