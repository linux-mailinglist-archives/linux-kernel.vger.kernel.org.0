Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518B18A71D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 21:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfHLTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 15:33:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfHLTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:33:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so43772329pgc.1;
        Mon, 12 Aug 2019 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lY5DGsJDc3Y+tZVDLUfZi0aZQ3PPwhIlfg0HaMz3r80=;
        b=AIa90ZoHoru2I9VNWKV4LI3OnccJG+8PO2earwb8sJ1A3wQX6fxRIoDZCylil+EBwN
         J+oaotTViWZOzUMaJKPAuqtTme4p/2ZbJPlqP43AuxmKmMlyiM+47KBPwdp7kcla5skW
         WP+GE+hLXpOt8FTJvImqMrnpBBEWwuXuLEIO7y4KYYU3vsvuQRXC5NdmXEPDZ44PyCxt
         i9A04iNEoqjKfBBfFZIGGaGWUMUm6YAV3T+pdi5y9FFvjpRAHCuNbuM/diDBodUoB3mK
         s+j7/9Otk7s00RjJJINSZh54p00zMCfUOPnNP7CeadBVeJH/vGTAbU8ogtgzQnjRGBSq
         4dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lY5DGsJDc3Y+tZVDLUfZi0aZQ3PPwhIlfg0HaMz3r80=;
        b=hiQYuB3sfKRUDa8GSEx2UfPkhDp6jBvcKoc/cYWmshYyTor3cytKyno1/6Gfm4RDAN
         pLFoz3pKIHLOCis3BvlkPNCNJMhlJ8W7v1F+J4Fo4f+PQmb33zxDdukXpGLvDHhyWaaH
         CmcmMFteCA56P6nsLgbW5i9QofFeENQO4WGdh9jQ7KWvGNgtSzIjLjI6j1NuJq1XpAoP
         l0m3zZser59wO0BR5q15WxfxOmBE8qV1lODfH0eohK89KmU1gN5zZDbaWlmjC9iCvBJn
         qgq1v7K5TsDiiM1sTwzbV/p3FGXUGM5kf2+s9ZrgKeCdvj+P+OORbWl54rkTt7XbOD/C
         eLOw==
X-Gm-Message-State: APjAAAVZTMlfopmzd0b+4I/oQnLcc5lB4U2dqLsRANdCoyIdoysvazMD
        sK3W7wreaqE/E1CYQ8gwhL0=
X-Google-Smtp-Source: APXvYqzxKWyH2qgTEFviQYl7Wab07MS3tFufvlF5TQB9I4OQAemdGgUgffTip/CtEultfSEqFSrcaQ==
X-Received: by 2002:a17:90a:b947:: with SMTP id f7mr788530pjw.63.1565638398324;
        Mon, 12 Aug 2019 12:33:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k36sm107627092pgl.42.2019.08.12.12.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 12:33:17 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:33:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Wang <wangzqbj@inspur.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miltonm@us.ibm.com, Yu Lei <mine260309@gmail.com>,
        duanzhijia01@inspur.com, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v3 2/2] hwmon: pmbus: Add Inspur Power System power
 supply driver
Message-ID: <20190812193315.GA25520@roeck-us.net>
References: <20190812025309.15702-1-wangzqbj@inspur.com>
 <6cf699d9-6efb-f701-d5ab-6f624e515ab8@roeck-us.net>
 <CAHkHK0_wts97mEjSOpZrKU8bTWKzh0+HBxTg0fSmdkFBsrWjFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkHK0_wts97mEjSOpZrKU8bTWKzh0+HBxTg0fSmdkFBsrWjFA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:48:34PM +0800, John Wang wrote:
> 
> So I should
> 
> 1. Add SENSOR_INSPUR_IPSPS to the end of the file
> 2. Add SENSOR_INSPUR_IPSPS in alphabetical order, without additional tab
> 3. other suggestions
> 
I would suggest 2). Just use a space before += instead of a tab.

Guenter
