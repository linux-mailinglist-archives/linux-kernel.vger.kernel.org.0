Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB779134B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgAHTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 14:43:17 -0500
Received: from brunni.mail.netestate.de ([81.209.177.48]:59759 "EHLO
        brunni.mail.netestate.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:43:17 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 14:43:16 EST
Received: (qmail 7632 invoked from network); 8 Jan 2020 19:36:34 -0000
Received: from localhost.netestate.de (HELO fiano.netestate.de) (127.0.0.1)
  by localhost.netestate.de with ESMTP; 8 Jan 2020 19:36:34 -0000
Received: from fiano.netestate.de (81.209.177.7)
  by brunni.mail.netestate.de with SMTP via TCP; Wed, 08 Jan 2020 20:36:34 +0100
Received: (qmail 17403 invoked by uid 503); 8 Jan 2020 19:36:34 -0000
Date:   Wed, 8 Jan 2020 20:36:34 +0100
From:   Michael Brunnbauer <brunni@netestate.de>
To:     linux-kernel@vger.kernel.org
Subject: reiserfs broke between 4.9.205 and 4.9.208
Message-ID: <20200108193634.GA17390@netestate.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi

after upgrading from 4.9.205 to 4.9.208, I get errors on two different
reiserfs filesystems when doing cp -a (the chown part seems to fail) and
on other occasions:

 kernel: REISERFS warning (device sda1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)

 kernel: REISERFS warning (device sdc1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)

This behaviour disappeared after a downgrade to 4.9.205.

I understand there have been changes to the file system code but I'm not
sure they affect reiserfs, e.g.

 https://bugzilla.kernel.org/show_bug.cgi?id=205433

Any Idea?

Regards,

Michael Brunnbauer

-- 
++  Michael Brunnbauer
++  netEstate GmbH
++  Geisenhausener Straße 11a
++  81379 München
++  Tel +49 89 32 19 77 80
++  Fax +49 89 32 19 77 89 
++  E-Mail brunni@netestate.de
++  https://www.netestate.de/
++
++  Sitz: München, HRB Nr.142452 (Handelsregister B München)
++  USt-IdNr. DE221033342
++  Geschäftsführer: Michael Brunnbauer, Franz Brunnbauer
++  Prokurist: Dipl. Kfm. (Univ.) Markus Hendel
